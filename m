Received: from eggs.gnu.org ([2001:4830:134:3::10]:51465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clxOz-0004tt-5A
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clxOw-0008B0-17
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:42:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1clxOv-0008At-RA
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:42:37 -0500
References: <7005a482-2372-0aaf-eb8b-60cd0a16b002@genode-labs.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c088c706-392f-e978-8edd-9db85a265681@redhat.com>
Date: Thu, 9 Mar 2017 13:42:34 +0100
MIME-Version: 1.0
In-Reply-To: <7005a482-2372-0aaf-eb8b-60cd0a16b002@genode-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH=C2=B1_SVM_I/O_permission_bitmap_?=
 =?utf-8?q?for_user-level_=28ring-3=29_code_ignored?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Boettcher <alexander.boettcher@genode-labs.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, ehabkost@redhat.com



On 05/03/2017 19:21, Alexander Boettcher wrote:
> the SVM I/O permission bitmap for user-level (ring-3) VM code running in
> SVM seems to be ignored and causes a GP-fault. (Actual the IO permission
> was granted by the kernel via the TSS I/O port permission bitmap).
> 
> After some debugging the GP code originates from target/i386/translate.c
> gen_check_io() within the if(s->pe && (s->cpl > s->iopl || s->vm86))
> condition. However, the actual SVM IO permission bitmap is checked after
> that condition, which succeeds and would permit the access.

>From your message it's not clear what is going wrong.  The code as is
written now matches the AMD manual: "Exceptions related to virtual x86
mode, IOPL, or the TSS-bitmap are checked before the SVM intercept
check. All other exceptions are checked after the SVM intercept check".

Please explain better what is going on:

1) does the TSS I/O permission bitmap grant permission to access the
port (the answer seems to be yes here)?

2) does the SVM I/O permission bitmap grant permission to access the port?

3) you get a #GP, do you expect the access to be trapped to the
hypervisor or not?

4) what is the exact instruction that the user-level code is executing?

Paolo
