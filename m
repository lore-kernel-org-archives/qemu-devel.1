Received: from eggs.gnu.org ([2001:4830:134:3::10]:49114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZfq9-0000jn-0Q
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZfq5-0002ej-3d
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:41:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:57674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gZfq3-0002dr-BR
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:40:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gZfpz-0005W3-Cx
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 17:40:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 610A72E80D2
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 17:40:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Dec 2018 17:31:26 -0000
From: Paolo Montesel <1809144@bugs.launchpad.net>
Reply-To: Bug 1809144 <1809144@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154524068665.20249.14759163527388138129.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809144] [NEW] SVM instructions fail with SVME
 bit enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I was trying to use QEMU/TCG to emulate some stuff that uses SVM.
I know SVM is only partially implemented but I gave it a try anyway.

I found that if SVM is enabled in the same basic block in which there's a c=
all to VMSAVE/etc,
the call fails as illegal op because the flags don't get updated correctly.

The pseudocode for the asm I'm running is:

```
EFER |=3D SVME; set the appropriate bit with wrmsr
vmsave
```

This is an example of the relevant translate.c code:

```
            if (!(s->flags & HF_SVME_MASK) || !s->pe) {
                goto illegal_op;
            }
            if (s->cpl !=3D 0) {
                gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
                break;
            }
```

s->flags doesn't get updated after the wrmsr instruction and so QEMU
raises an illegal opcode interrupt.

A quick fix is to make the tb end after `wrmsr` instructions, but it's an h=
ack afaik.
I'm not too comfortable with QEMU's code, so I don't know what a proper fix=
 would be.

Cheers,

thebabush

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809144

Title:
  SVM instructions fail with SVME bit enabled

Status in QEMU:
  New

Bug description:
  I was trying to use QEMU/TCG to emulate some stuff that uses SVM.
  I know SVM is only partially implemented but I gave it a try anyway.

  I found that if SVM is enabled in the same basic block in which there's a=
 call to VMSAVE/etc,
  the call fails as illegal op because the flags don't get updated correctl=
y.

  The pseudocode for the asm I'm running is:

  ```
  EFER |=3D SVME; set the appropriate bit with wrmsr
  vmsave
  ```

  This is an example of the relevant translate.c code:

  ```
              if (!(s->flags & HF_SVME_MASK) || !s->pe) {
                  goto illegal_op;
              }
              if (s->cpl !=3D 0) {
                  gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
                  break;
              }
  ```

  s->flags doesn't get updated after the wrmsr instruction and so QEMU
  raises an illegal opcode interrupt.

  A quick fix is to make the tb end after `wrmsr` instructions, but it's an=
 hack afaik.
  I'm not too comfortable with QEMU's code, so I don't know what a proper f=
ix would be.

  Cheers,

  thebabush

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809144/+subscriptions
