Received: from eggs.gnu.org ([2001:4830:134:3::10]:54523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cvRJK-0002z6-M1
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cvRJH-0005QR-Gj
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:28:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cvRJH-0005QG-7i
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:27:59 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v34GNqvw119463
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 12:27:56 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29m4e5sx2q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 12:27:56 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 4 Apr 2017 12:27:55 -0400
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
	<CAJ+F1CKVU+bgyE2Z7v3kECZ-GVLj+gMiiRoSZt7yWGMj0UkfgA@mail.gmail.com>
	<20170404154355.GY25661@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 4 Apr 2017 12:27:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170404154355.GY25661@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6d27ca2f-219f-c888-0555-b655b1216fa0@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] Provide support for the software TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, patrick.ohly@intel.com, qemu-devel@nongnu.org

On 04/04/2017 11:43 AM, Daniel P. Berrange wrote:
> On Mon, Apr 03, 2017 at 05:18:37PM +0000, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Mon, Apr 3, 2017 at 7:08 PM Daniel P. Berrange <berrange@redhat.com=
>
>> wrote:
>>
>>> On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
>>>> Briefly, Theses set of patches introduces:
>>>>   - new TPM backend driver to support software TPM emulators(swtpm(1=
)).
>>>>   - and few supported fixes/enhancements/cleanup to existing tpm bac=
kend
>>> code.
>>>> The similar idea was initiated earliar(2) by Stefan Berger(CCed) wit=
h
>>> slightly
>>>> different approach, using CUSE. As swtpm has excellent support for u=
nix
>>> domain
>>>> sockets, hence this implementation uses unix domain sockets to
>>> communicate with
>>>> swtpm.
>>>>
>>>> When Qemu is configured with 'emulator' tpm backend, it spawns 'swtp=
m'
>>> and
>>>> communicates its via Unix domain sockets.
>>> I'm not convinced that having QEMU spawning swtpm itself is a desirab=
le
>>> approach, as it means QEMU needs to have all the privileges that swtp=
m
>>> will need, so that swtpm can inherit them. At the very least I think =
we
>>> need to have a way to disable this spawning, so it can connect to a
>>> pre-existing swtpm process that's been spawned ahead of time. This wi=
ll
>>> let us have stricter privilege separation.
>>>
>> Could the security contexts be given as arguments to qemu for the
>> subprocesses? The reason to have qemu spawn its own subprocess is that=
 it
>> would leave more flexibility on how and when to do it, or even to use
>> multiple subprcesses if some day that makes sense. If there is no reas=
on to
>> make this interface public or shared by various other processes, I wou=
ld
>> rather see it as internal to qemu rather than managed by other tools. =
It
>> also makes command line & testing easier.
> If QEMU is responsible for spawning it, then swtpm would have to run as=
 the
> same user/group as QEMU, as we do not want QEMU to have ability to invo=
ke
> programs with setuid. This means any state files / config / devices tha=
t
> swtpm has to access would also be accessible by QEMU directly (assuming=
 just
> DAC controls, no MAC like SELinux). It also means that swtpm would be a=
ble
> to access QEMU resources - so a bug in swtpm would allow swtpm to compr=
omise
> the guest disk image and other resources QEMU access.
>
> If by contrast, libvirtd is responsible for spawning it, or an even a h=
igher
> level mgmt app like OpenStack/oVirt, then swtpm can be run with complet=
ely
> isolated user / group privileges. The only resource that QEMU needs acc=
ess
> to is the UNIX domain socket, and swtpm doesn't need to access anything
> belonging to QEMU. This will give us much stronger security separation
> between swtpm & QEMU.  It will also allow us to write a more useful sec=
comp
> policy that entirey blocks exec() from QEMU, further mitigating damage =
from
> potential QEMU exploits.

Here are my patches for libvirt. They are pretty old by now. (won't=20
forward port unless...)

https://github.com/stefanberger/libvirt-tpm/commits/v1.2.14-maint-vtpm

    Stefan
