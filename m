Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB15C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D8421775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/nu0cI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D8421775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziAR-0001N2-IG
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izi8M-0006rw-5N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izi8L-0003tM-82
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:27:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izi8L-0003t9-4Q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580999276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lpzGvS4Evi0F0VFTfU/xDT+BFqcMUG64/th2zcOBUk=;
 b=K/nu0cI6JNF4EhEe+lG3zIyqqvKvghK0MZxaZQFI9aq0QgSmWLuKpRXNyb2Ou6X2sl5yMx
 mEZnNR555DJcwqYgVVUjyKiPr+rnfmy286CMYmBsCNPJ5DojTLxMgTP/9CsNaxf4FIzo9w
 lLpMQC2Fh/ms/J9Lu37iProztk0BT9g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-E6nTZRTwOyq_z8cu_LXGcQ-1; Thu, 06 Feb 2020 09:27:55 -0500
Received: by mail-wr1-f70.google.com with SMTP id u18so3439771wrn.11
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 06:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c2C7Qg6sOddmcl6RMRrfTJYESyA7AnRp1mqrpD6UTrE=;
 b=G4eqfsut1pWt4lsz7q4drsqjJAPXLGZiL0JvIBTmn+dCKtkFZ6jnEjr4gM0DZcWXVF
 saBD5Ai+CHamQ4EUz2LBlxzOmiBCWZ/HRHdiWHnXYEr1r3U3RUSbhnSNGcS2FE+dzMcp
 jf6hZM6rygWHvUzQZKtpf+x9+uYHM6CqkSfNyc/W3JXFomXu2S9L9eqI5FJAJUjv79nc
 n1q/EWy4lr1whdCSYtxRW2yDZ7PiZai4ldyQ762CtN1jHyZFtIraI08fIZ+VLRqQi+cj
 S9kokocwm4208A+VCFruBSjpaQ+WIFie8xfMh2o81dCu+/YPzOBwraQONowxV3Db6x24
 WCJA==
X-Gm-Message-State: APjAAAUz17EkOssmJFPIHqqLOkUt/+xLYaus425E0WzgEltVA6rFpuDs
 cnOAnXNX5z9jNI1g5wlZq/ZEu2xDi8C2J+81ayrrKtAKSNhNWN7Xogim34PYkS5PS7wdhCmK+Xh
 wFb8RRNFSNdCGppQ=
X-Received: by 2002:adf:f244:: with SMTP id b4mr3951842wrp.88.1580999270781;
 Thu, 06 Feb 2020 06:27:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFIgz3GlX98gHIsDJfVVxYyGwc5U/v2TEsVuDvflGURTfjNYcBVCnw3ujT+rX1boT5xOEFSA==
X-Received: by 2002:adf:f244:: with SMTP id b4mr3951824wrp.88.1580999270615;
 Thu, 06 Feb 2020 06:27:50 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y17sm4331770wrs.82.2020.02.06.06.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 06:27:50 -0800 (PST)
Subject: Re: [PATCH v2 3/6] travis.yml: install rpm2cpio for acceptance tests
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-4-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ed96f242-44cd-a846-be06-971db6e7ef1d@redhat.com>
Date: Thu, 6 Feb 2020 15:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580914565-19675-4-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-MC-Unique: E6nTZRTwOyq_z8cu_LXGcQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wainersm@redhat.com,
 slp@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 3:56 PM, Liam Merwick wrote:
> The extract_from_rpm() method added for the PVH acceptance tests needs
> rpm2cpio to extract a vmlinux binary from an RPM.
>=20
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   .travis.yml | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 3b35b7cf04d3..59773365823e 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -323,6 +323,7 @@ matrix:
>               - python3-pil
>               - python3-pip
>               - python3.5-venv
> +            - rpm2cpio
>               - tesseract-ocr
>               - tesseract-ocr-eng
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


