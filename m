Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE98C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 08:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264C72073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 08:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPoZZvDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264C72073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieEfc-0001It-BS
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 03:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieEei-0000t9-DK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieEee-0006Ls-I4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:44:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieEee-0006LU-BF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575881070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AREEEFc7WobbjDO1ZDfCWOXyVMFF/beXYsrk31S4gLk=;
 b=gPoZZvDcszmCzLzPFOm5HtQ3iHqtBZo4HDTQFVLi066Pl0mbFK8Ffv5HV9e29ejLO1JSSs
 jRkMjn/K4XwTYijGI2ws389G0DSPq/d0drYMORK8dwJNg+P3Mf2Q3MOYcA9boXHYNMpAeN
 RXiek37IbmVoRc6hjycIdhOn1sxy7rQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-ovH3tON1MRW0D5zJ_az4LQ-1; Mon, 09 Dec 2019 03:44:29 -0500
Received: by mail-wr1-f69.google.com with SMTP id c17so7142830wrp.10
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 00:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=v9e7/+fPJHI/zHKCNa6WmWtmI763tlIEUcplC/O2NNk=;
 b=DSaSlPrB/9tyWA12TqQk158udB2xb2xpiSzoxpILbrHaMBrY+F5cds58wRHCVv0BUb
 Z1yu6Hesfcd4cNr++tTLJ3S1a3XPlrDJnD/dtNYR+xcBZaFLjPukawyQs5z2pBNCDQ3A
 gbs0WeR4njjc9CtZQo50sNi2K8PeQyUIhFzwRWdrcvy74KG1EO8pf+4BY8CMK+QSdYRP
 t81nro3xCwvwM/wtYszXJ2eLMxuR2m1YPzEQqNLsK8ANzhWI3pXPFz1Ppd0gzTuAEsPg
 92kb6LrqH2lZF6y6hMbi5Fx4t50EqvPNsXDvdh2srZmvsvx3nBcqhT4j+TF8KZt+/F3j
 pgVw==
X-Gm-Message-State: APjAAAVTva6wQed+cJIa0xvxR+wXIAkmGzKUm2FJykk7jzfy8qvLMijy
 ZaMLcWesN0lGGBS2tlJFtsM5z6bHPOj4PXigaI/vWVGgfcuvQsTVLvcxNy30dDMWZxIazGx0FkY
 WSA9J6ViGj1tH08E=
X-Received: by 2002:a05:600c:2144:: with SMTP id
 v4mr24709880wml.31.1575881068099; 
 Mon, 09 Dec 2019 00:44:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxXUn0hE7F1M4OmGLojJvpnBDUUeuF3yvNyQazrKE0lC89Vk1Su0x2EN4Ca4IrjErLNkeTWA==
X-Received: by 2002:a05:600c:2144:: with SMTP id
 v4mr24709852wml.31.1575881067864; 
 Mon, 09 Dec 2019 00:44:27 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id e6sm25304347wru.44.2019.12.09.00.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 00:44:27 -0800 (PST)
To: Peter Maydell <peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: [RFC] Use of the Nacked-by tag by CI scripts
Message-ID: <4cbaadf8-ae4f-d086-2137-b83d61a5e9a5@redhat.com>
Date: Mon, 9 Dec 2019 09:44:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: ovH3tON1MRW0D5zJ_az4LQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The Nacked-by tag can be used to manually hold a patch for further=20
review, or by automatic CI because of failing test.

We often miss travis-ci and shippable failures. These CI provide a easy=20
way to send email on failure, we can integrate the Nacked-by use there.

We can easily have patchew script send a Nacked-by tag.

If there is a consensus about using this tag, the following patch can be=20
added to Peter's management scripts:
https://git.linaro.org/people/pmaydell/misc-scripts.git/

If we move to another workflow, having this uniform tag can help future=20
merging scripts to avoid patch on hold to get automatically merged.

-- >8 --
Subject: make-pullreq: Do not automatically merge NAcked commits

The 'Nacked-by' tag is a polite way of holding a patch for
further review. Reviewers might share their disapproval with
it (see [1]).

CI scripts might NAck a patch if it breaks testing.
QEMU already thought about using this tag for CI by the past
(see [2]).

The patchwork tool already collects this tag (see [3]).

Also, there was a discussion at the last Open Source Summit
about standardizing it ([4]).

Maintainers might miss a such Nacked-by tag. Help them by
providing a last resort check before merging pull requests.

[1]=20
https://www.x.org/wiki/Development/Documentation/SubmittingPatches/#index1h=
1
[2] https://lists.gnu.org/archive/html/qemu-devel/2013-01/msg00196.html
[3]=20
http://git.ozlabs.org/?p=3Dpatchwork;a=3Dblobdiff;f=3Dapps/patchwork/models=
.py;h=3Dfa213dc03e;hp=3D8871df0259e;hb=3D487b53576f;hpb=3Da59ebf107d84b
[4]=20
https://lore.kernel.org/workflows/CACT4Y+bxPxQ64HEO2uGRkbk9vJSeg64y10Lak4c2=
K54J7GyFFA@mail.gmail.com/

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
  make-pullreq | 11 +++++++++++
  1 file changed, 11 insertions(+)

diff --git a/make-pullreq b/make-pullreq
index 61c0f1d..fff0b2d 100755
--- a/make-pullreq
+++ b/make-pullreq
@@ -108,6 +108,17 @@ if [ "$bad" =3D "yes" ]; then
     exit 1
  fi

+# Check no commit contains a nacked-by tag
+for rev in $(git rev-list master..HEAD); do
+    if git log ${rev}^! | grep -iq "Nacked-by:"; then
+        echo "Error: commit ${rev} nacked"
+        bad=3Dyes
+    fi
+done
+if [ "$bad" =3D "yes" ]; then
+   exit 1
+fi
+
  # Check whether any authors needs to be corrected after SPF rewrites
  if git shortlog --author=3Dqemu-devel@nongnu.org master..HEAD | grep .; t=
hen
      echo "ERROR: pull request includes commits attributed to list"
--=20
2.21.0


