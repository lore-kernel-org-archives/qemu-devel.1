Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBF5C433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE85B207F9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUk7I1sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE85B207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvJF-0001tk-Oz
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1juvIW-0001T1-HS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:02:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1juvIS-0003Wc-Lx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594634571;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JrJpyJ98cIDfNhcKWqTGGiR+INFTnJ0FGAs2hCGH8Y=;
 b=PUk7I1sg325YwNA9KmAR8GPKrLgW/M5eNRDRtN44ZfJ7SAYxrzvGcwdoEiVhVA7LOhm6XU
 SXsurR59ozUUSbtrHzCO+d/TBaptQT3qQ+k58mSClpBE5raHcAdNHrtSNlCqkLSKwAFP/U
 uzI14i24KPbvu3sLF3VZwRrWQD0UySY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-mn5zVLcMMZm6VGbtqPxkIA-1; Mon, 13 Jul 2020 06:02:49 -0400
X-MC-Unique: mn5zVLcMMZm6VGbtqPxkIA-1
Received: by mail-wm1-f69.google.com with SMTP id y204so18056376wmd.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 03:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/JrJpyJ98cIDfNhcKWqTGGiR+INFTnJ0FGAs2hCGH8Y=;
 b=pzake3T7zfyxXGqdgF+TRJfBLoyhS0FxGmTBkH6DS3q2VcHXMqVWdFywIqXG3jtSyu
 fPWlhZ7tU0hBDlu3Bccrabj+FSt50ktES1AUGktODO8JuIj4xLiB/w2Oe46MEKK+swld
 43YuXHSUN95PYEMS5P4iPWJ82ptgX5oIn6Q27wokRzT45G/EKhyyTNn1LPVQd2eWsVlu
 i87yZ8sKUjMjEj9NXFl5cZANN4kzQWtKI0nJtqilNcOpO+I68oJUGoESOr+2SWjln7E6
 9m/c+TIzSouN6nYsEeBBqNmoBkPPPQHS4bYHfyDDsJ726N9aaY4nFjxMV46EhTgGmEL1
 9F6Q==
X-Gm-Message-State: AOAM531SPVostA6kFu79hIczum+uupdsZOD9uGr5PeT8hAX4y/9XjmAF
 CWdDuhP+3dwLfS3Uk+6aYwm54Y/aoGUSsDbgt4dw7lEW5cYgqrBsIp4WpjWHlnP/4fsyNZtoh4I
 oxV6pIjYtLTVu+Hc=
X-Received: by 2002:adf:e944:: with SMTP id m4mr80825769wrn.252.1594634568819; 
 Mon, 13 Jul 2020 03:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYNJ7pk3TVzzMw4PhWd4jYw/D4vHeP0kIUSvE7hGi8A6dWocNmFjN3m8ms9SAM8Xgo3TDgaA==
X-Received: by 2002:adf:e944:: with SMTP id m4mr80825750wrn.252.1594634568602; 
 Mon, 13 Jul 2020 03:02:48 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id 133sm23279767wme.5.2020.07.13.03.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 03:02:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH 07/12] vnc: Remove the superfluous break
In-Reply-To: <1594631086-36509-1-git-send-email-wang.yi59@zte.com.cn> (Yi
 Wang's message of "Mon, 13 Jul 2020 17:04:46 +0800")
References: <1594631086-36509-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 13 Jul 2020 12:02:46 +0200
Message-ID: <87imer20mx.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: quintela@redhat.com
Cc: xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn, qemu-devel@nongnu.org,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yi Wang <wang.yi59@zte.com.cn> wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
>
> Remove the superfluous break, as there is a "return" before.
>
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>a
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


