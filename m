Received: from eggs.gnu.org ([2001:4830:134:3::10]:42796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSpFw-0008LN-Me
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fSpFr-0003tX-Qk
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:47:04 -0400
Received: from mail-sn1nam02on0066.outbound.protection.outlook.com
	([104.47.36.66]:2386
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fSpFr-0003t2-AP
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:46:59 -0400
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-4-git-send-email-babu.moger@amd.com>
	<20180611205030.GW7451@localhost.localdomain>
	<20180611211026.GA7451@localhost.localdomain>
	<DM5PR12MB247152846B93E574639E3AE7957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180612174021.GL7451@localhost.localdomain>
	<DM5PR12MB2471F6EA1525A824A9A94545957F0@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180612190554.GO7451@localhost.localdomain>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <39f328af-a9c1-15bb-653e-9456b045768d@amd.com>
Date: Tue, 12 Jun 2018 14:46:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180612190554.GO7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v13 3/5] i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>, Jiri Denemark <jdenemar@redhat.com>



On 06/12/2018 02:05 PM, Eduardo Habkost wrote:
> On Tue, Jun 12, 2018 at 06:38:08PM +0000, Moger, Babu wrote:
> [...]
>>> I'm starting to think that enabling TOPOEXT automatically is
>>> adding too much complexity and compatibility problems, and it's
>>> better to leave this task to management software.
>>>
>>> The main problem here is:
>>>
>>> This works today with QEMU 2.12 + Linux <=3D 4.15:
>>>    $ $QEMU -machine pc -cpu EPYC,enforce -smp
>>> 8,sockets=3D2,cores=3D2,threads=3D2"
>>> and must keep working with QEMU 3.0 and Linux <=3D 4.15.
>>>
>>> In addition to that, the results for:
>>>    $ $QEMU -machine pc-q35-3.0 -cpu EPYC,enforce [...]
>>> must be deterministic and expose exactly the same CPUID data even
>>> if host hardware or software changes, as long as the QEMU
>>> command-line is the same.
>>>
>>> Do you see a way to fulfill those two constraints while making
>>> "-machine pc-q35-3.0 -cpu EPYC" enable TOPOEXT automatically?
>>>
>> Now(setting feature before x86_cpu_expand_features), enabling
>> TOPOEXT appears to work fine.
> What about the above constraints?  Are you really fulfilling
> them?
>
> This one is tricky:
>
> ] This works today with QEMU 2.12 + Linux <=3D 4.15:
> ]   $ $QEMU -machine pc -cpu EPYC,enforce -smp 8,sockets=3D2,cores=3D2,th=
reads=3D2"
> ] and must keep working with QEMU 3.0 and Linux <=3D 4.15.
 =C2=A0This works fine on kernel <=3D 4.15 with some warnings(-smp=20
8,sockets=3D2,cores=3D2,threads=3D2 -cpu EPYC).

qemu-system-x86_64: warning: host doesn't support requested feature:=20
CPUID.80000001H:EDX.rdtscp [bit 27]
qemu-system-x86_64: warning: host doesn't support requested feature:=20
CPUID.80000001H:ECX.topoext [bit 22]
qemu-system-x86_64: This family of AMD CPU doesn't support=20
hyperthreading(2). Please configure -smp options properly or try=20
enabling topoext feature.
continues..
>
> If we enable TOPOEXT unconditionally, the command-line won't work
> with Linux <=3D 4.15.
>
> If we enable TOPOEXT only if the kernel returns TOPOEXT on
> GET_SUPPORTED_CPUID, we break the second constraint:
>
> ] The results for:
> ]   $ $QEMU -machine pc-q35-3.0 -cpu EPYC,enforce [...]
> ] must be deterministic and expose exactly the same CPUID data even
> ] if host hardware or software changes, as long as the QEMU
> ] command-line is the same.
>
This fails on kernel=C2=A0 <=3D 4.15 with following messages((-smp=20
8,sockets=3D2,cores=3D2,threads=3D2 -cpu EPYC,enforce).
qemu-system-x86_64: warning: host doesn't support requested feature:=20
CPUID.80000001H:EDX.rdtscp [bit 27]
qemu-system-x86_64: warning: host doesn't support requested feature:=20
CPUID.80000001H:ECX.topoext [bit 22]
qemu-system-x86_64: Host doesn't support requested features
exits..

What do you think our options are here?
