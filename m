Received: from eggs.gnu.org ([2001:4830:134:3::10]:44816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1gPYoM-00057i-Kl
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 15:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1gPYfM-00053Y-1Z
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 15:00:07 -0500
Received: from mail1.windriver.com ([147.11.146.13]:51565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1gPYfL-0004wO-PX
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 15:00:03 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wALHcJYU004539
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 09:38:19 -0800 (PST)
References: <d5d6e09a-78ed-41c4-bbb9-260263c05bf2@windriver.com>
	<87pnvn6hnq.fsf@linaro.org>
	<b109fe05-1e88-a6e3-34cb-21a4b61e64b3@windriver.com>
	<87lg6b5shx.fsf@linaro.org>
	<98428a27-8634-9521-297c-a61c618e867a@windriver.com>
	<20181102175111.GA2388@work-vm>
	<54304edc-9de4-a25a-63d0-96518c5d7956@windriver.com>
From: Chris Friesen <chris.friesen@windriver.com>
Message-ID: <eedf3d4a-62c2-d1c7-1dbf-ae9cf5e09e11@windriver.com>
Date: Wed, 21 Nov 2018 11:38:16 -0600
MIME-Version: 1.0
In-Reply-To: <54304edc-9de4-a25a-63d0-96518c5d7956@windriver.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] strange situation,
 guest cpu thread spinning at ~100%, but display not yet initialized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 11/2/2018 2:45 PM, Chris Friesen wrote:
> On 11/2/2018 11:51 AM, Dr. David Alan Gilbert wrote:

>> =C2=A0=C2=A0=C2=A0 so the fix is Fam's 'aio: Do aio_notify_accept only=
 during blocking
>> aio_poll'.=C2=A0 I see you're running the qemu-kvm-ev from centos, if =
I read
>> the version tea-leaves right, then I think that patch is in the
>> 2.10.0-21.el7_5.7.1 package I can see.
>=20
> It looks like we do not have this fix in our code, will definitely be=20
> giving it a try.
Well, it appears that this was not the fix.  With the patches applied we=20
still saw the problem.

One of my coworkers has been investigating further, and he sent me the=20
following information:

"One of the things the BIOS does before initializing the VGA is to start=20
the CPUs. More specifically, from CPU-0, it broadcasts a Setup=20
InterProcess Interrupt (SIPI) to all the remaining processors so that=20
they wake up and are initialized. CPU-0 busy-waits for all the=20
Instance=E2=80=99s CPUs to be initialized, and once that happens, it move=
s on to=20
continue booting (which includes initializing the VGA).  In our case,=20
one CPU fails to respond to the SIPI causing CPU-0 to keep busy waiting=20
for it. I am in the process of adding more instrumentation to qemu so=20
that we can know whether the missing CPU did not receive the SIPI or=20
what happened."

Chris
