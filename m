Received: from eggs.gnu.org ([2001:4830:134:3::10]:50026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gVMX9-00044S-AI
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 15:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gVMX6-0001dy-6W
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 15:15:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gVMX5-0001dS-T6
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 15:15:32 -0500
References: <1544049083-16087-1-git-send-email-liam.merwick@oracle.com>
	<c7e0dcd0-11fe-9ddd-defb-78e51a59d072@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <7d478952-03b6-37f1-2c3e-acf4856b5c34@oracle.com>
Date: Fri, 7 Dec 2018 20:15:24 +0000
MIME-Version: 1.0
In-Reply-To: <c7e0dcd0-11fe-9ddd-defb-78e51a59d072@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] qboot changes for PVH boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, maran.wilson@oracle.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, George Kennedy <george.kennedy@oracle.co>, liam.merwick@oracle.com



On 06/12/2018 20:13, Paolo Bonzini wrote:
> On 05/12/18 23:31, Liam Merwick wrote:
>> For certain applications it is desirable to rapidly boot a KVM virtual
>> machine. In cases where legacy hardware and software support within th=
e
>> guest is not needed, QEMU should be able to boot directly into the
>> uncompressed Linux kernel binary with minimal firmware involvement.
>>
>> There already exists an ABI to allow this for Xen PVH guests and the A=
BI
>> is supported by Linux and FreeBSD:
>>
>>     https://xenbits.xen.org/docs/unstable/misc/pvh.html
>>
>> Details on the Linux changes: https://lkml.org/lkml/2018/4/16/1002
>>
>> This patch series provides qboot support to populate the start_info st=
ruct
>> needed by the direct boot ABI and to configure the guest e820 tables t=
o
>> enable QEMU to use that same entry point for booting KVM guests.
>>
>> Us=D1=96ng the methods/scripts documented by the NEMU team at
>>
>>     https://github.com/intel/nemu/wiki/Measuring-Boot-Latency
>>     https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00200.htm=
l
>>
>> below are some timings measured (vmlinux and bzImage from the same bui=
ld).
>> Time to get to kernel start is almost halved (95=E1=B9=81s -> 48ms)
>=20
> I had a few comments on patch 2, but overall it looks fine.  Can you
> send a pull request on GitHub?
>=20

Thanks Paolo.  I have made those changes and submitted a PR:

https://github.com/bonzini/qboot/pull/17

Regards,
Liam


>=20
>> QEMU + qboot + vmlinux (PVH + 4.20-rc4)
>>   qemu_init_end: 41.550521
>>   fw_start: 41.667139 (+0.116618)
>>   fw_do_boot: 47.448495 (+5.781356)
>>   linux_startup_64: 47.720785 (+0.27229)
>>   linux_start_kernel: 48.399541 (+0.678756)
>>   linux_start_user: 296.952056 (+248.552515)
>>
>> QEMU + qboot + bzImage:
>>   qemu_init_end: 29.209276
>>   fw_start: 29.317342 (+0.108066)
>>   linux_start_boot: 36.679362 (+7.36202)
>>   linux_startup_64: 94.531349 (+57.851987)
>>   linux_start_kernel: 94.900913 (+0.369564)
>>   linux_start_user: 401.060971 (+306.160058)
>>
>> QEMU + bzImage:
>>   qemu_init_end: 30.424430
>>   linux_startup_64: 893.770334 (+863.345904)
>>   linux_start_kernel: 894.17049 (+0.400156)
>>   linux_start_user: 1208.679768 (+314.509278)
>>
>>
>> Liam Merwick (3):
>>    pvh: Add x86/HVM direct boot ABI header file
>>    pvh: use x86/HVM direct boot ABI
>>    pvh: add benchmark exit point
>>
>>   benchmark.h          |   3 +-
>>   fw_cfg.c             |  79 +++++++++++++++++++++++++++-
>>   include/start_info.h | 146 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   linuxboot.c          |   2 +-
>>   main.c               |   3 ++
>>   tables.c             |   9 ++++
>>   6 files changed, 239 insertions(+), 3 deletions(-)
>>   create mode 100644 include/start_info.h
>>
>=20
