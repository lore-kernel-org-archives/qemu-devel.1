Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E54CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B199A20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ldos5N8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B199A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbpu-00082S-7V
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNb4Z-000644-Q4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNb4Y-0002DS-Gi
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:14:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:45724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNb4Y-0002Cb-4v
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:14:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id q13so20636977wrs.12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=f63dB6hLG8yXun8B3m+kJKUwp9SZsm+9kHC3CVxTHYY=;
 b=Ldos5N8fDKiQpHNrsRoDB0u2uP++bu15v95BzAvY6kWgJQql7Gvxt6iwtGZtI95hTp
 r/8mwDPVnHJN0TMMnxEDEt1uAO7MuutL6cMhiKGYcT/dMz1FBzuC1EmUWT6HMAtZxkBE
 jkDG4vBJj7P50SVhxMR0BuouvNVChQtlqiaYOsS54d7uKtbLp2JBW9Gk3GMmJqwpU/mF
 hn5X6rpvJlFFCDSl0zhZBajsLm93fiQffU7VQBf5YxzmNyGgyEiQTiuhiQG8caQKPjjb
 Dl8N7Yaa7Vk/68jePtnZpG1k1Q6Pm3zEJh1oRRb5wfzK2Xo7cVxqaE9ei2B0Egq+nUTY
 Ouag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=f63dB6hLG8yXun8B3m+kJKUwp9SZsm+9kHC3CVxTHYY=;
 b=B2CIGflkxWy6WTaZkrpPR8tmmc/Ee3gGC9Djsp0qyiDg+enxYiz9RrXwDTsGlWkQKH
 WX15DJiicCKdrTde0zRGCoAJLJu0ibXhB2P1Yq5LunpOAGtijE8xomgaStiNb+juYXMZ
 nVymPXGdmAD45j1hYv3Q23IieNs+ufOhkw+5TCOF/T8oaU8e0uEbB4LA1nuM2NGRY94i
 luf1z0nEh89GcB723X8BucjNIWQVwNECBxRvRHRkKoaZFo5R/Kze6k4WXhC7HU7kcfqx
 AD6dh9o+f9jk0552cpxLx/2yVbk9kRW9s1zzfw5eJ1i2PQ82nM66ny1D+wbBcr+0g3wz
 0lZA==
X-Gm-Message-State: APjAAAUjSYUm3YU9oM9vLn1AcCOqX/Cv+ODSkDc46MNw696V8/jIuQnV
 A4nf7+kOLTqOVd5eMsds859DIQ==
X-Google-Smtp-Source: APXvYqwAvv+BDWf+ueCxqjW152AvXJJnzNj8JCZyYp+pIRTgCVVATrNnYTOhOt8h8VQeDPIqNDDUYQ==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr3543854wrw.73.1571915668347;
 Thu, 24 Oct 2019 04:14:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i18sm22886295wrx.14.2019.10.24.04.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 04:14:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C0C3C1FF87;
 Thu, 24 Oct 2019 12:14:26 +0100 (BST)
References: <20191022072135.11188-1-thuth@redhat.com>
 <20191022072135.11188-6-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 5/6] iotests: Enable more tests in the 'auto' group
 to improve test coverage
In-reply-to: <20191022072135.11188-6-thuth@redhat.com>
Date: Thu, 24 Oct 2019 12:14:26 +0100
Message-ID: <87ftjimm3x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

<snip>
>
> According to Max, it would be good to have a test for iothreads and
> migration. 127 and 256 seem to be good candidates for iothreads. For
> migration, let's enable 091, 181, and 203 (which also tests iothreads).
<snip>
> @@ -112,7 +112,7 @@
>  088 rw quick
>  089 rw auto quick
>  090 rw auto quick
> -091 rw migration
> +091 rw auto migration


This is breaking consistently on my ZFS machine:

TEST    iotest-qcow2: 091 [fail]
QEMU          -- "/home/alex.bennee/lsrc/qemu.git/tests/qemu-iotests/../../=
x86_64-softmmu/qemu-system-x86_64" -nodefaults -display none -machine accel=
=3Dqtest
QEMU_IMG      -- "/home/alex.bennee/lsrc/qemu.git/tests/qemu-iotests/../../=
qemu-img"
QEMU_IO       -- "/home/alex.bennee/lsrc/qemu.git/tests/qemu-iotests/../../=
qemu-io"  --cache writeback -f qcow2
QEMU_NBD      -- "/home/alex.bennee/lsrc/qemu.git/tests/qemu-iotests/../../=
qemu-nbd"
IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 hackbox2 4.15.0-66-generic
TEST_DIR      -- /home/alex.bennee/lsrc/qemu.git/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER -- /home/alex.bennee/lsrc/qemu.git/tests/qemu-iotests/soc=
ket_scm_helper

--- /home/alex.bennee/lsrc/qemu.git/tests/qemu-iotests/091.out  2019-02-19 =
12:32:03.231730789 +0000
+++ /home/alex.bennee/lsrc/qemu.git/tests/qemu-iotests/091.out.bad      201=
9-10-24 12:07:00.624967556 +0100
@@ -9,20 +9,4 @@

 =3D=3D=3D VM 1: Migrate from VM1 to VM2 =3D=3D=3D

-vm1: qemu-io disk write complete
-vm1: live migration started
-vm1: live migration completed
-
-=3D=3D=3D VM 2: Post-migration, write to disk, verify running =3D=3D=3D
-
-vm2: qemu-io disk write complete
-vm2: qemu process running successfully
-vm2: flush io, and quit
-Check image pattern
-read 4194304/4194304 bytes at offset 0
-4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Running 'qemu-img check -r all $TEST_IMG'
-No errors were found on the image.
-80/16384 =3D 0.49% allocated, 0.00% fragmented, 0.00% compressed clusters
-Image end offset: 5570560
-*** done
+Timeout waiting for (qemu) on handle 0


--
Alex Benn=C3=A9e

