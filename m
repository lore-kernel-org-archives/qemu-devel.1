Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACA9C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BB520714
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QV7fv8Rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BB520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBelN-0001Zr-Ve
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kBej5-00060R-9Q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:47:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1kBej3-0000Pe-M4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598622448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERdT69ax0+kZdzAbXsFNb+QP37dCpZZsDlf1oMe4UE4=;
 b=QV7fv8RfkKuXfvAKXCIezKEn4xZX82czLKaQwLXd8e19rpM9RZKMxrkxFMQaTRifzd9qN4
 L4uNW6DbfGdJ+1L2xNkeGpSBYmm8SPQdhdgtL2OrDjmTRm+RGdJF7go1VcY91pFOz3zfLA
 sjbgxiDqLN7vi/KlPuyp7FAMx59281M=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-X3paKuH1Ptq45AzuM-oy9Q-1; Fri, 28 Aug 2020 09:47:27 -0400
X-MC-Unique: X3paKuH1Ptq45AzuM-oy9Q-1
Received: by mail-io1-f72.google.com with SMTP id k133so922920iof.16
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 06:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ERdT69ax0+kZdzAbXsFNb+QP37dCpZZsDlf1oMe4UE4=;
 b=BEr0g0HYZCXP70nPDtuQg8mLBfgoRZWyw6Mbq8T2TsY8tJBA18L8UhOHzIEAQWVdoy
 u4GpvNNnpFTQ+u/C/UhvbbR2KxZjYBWzBqjjnNJPEL2lUZVxqOqgVVH0rz9VDYIfS73r
 1mcQl8uaP9fY2cX3a7i3wbi7rbud/wggkfC+3Jkzui3qbySvmIRoX4VcPXUBUc55CgTv
 YebA1M24iFWIp9/wuoWQ36hCtAlWFeKdauq7ok83dO+aDRrFSfP5uTafBSVx96OJbLgZ
 P1iba9zrG5poztzRACQamLQ7nFkmjOZx+GY8CAIv3XkRsYDiumz7REUemUwR48n7CuRO
 YlBg==
X-Gm-Message-State: AOAM533UX9Ki2y51Ibyv2Uj6noL0x6a8/PmCTpbPFqVWAlbiXubfLoXD
 NP9AjXltbvnpkr9LlHDCyQfg/S6yyg78b2oJAeoNRNTjYdEBVmL1vzx7s2AINuUV6tUGKKNvcA+
 myE58NX3DWJofuQU+MrFoIljRv2h9+fo=
X-Received: by 2002:a92:4f:: with SMTP id 76mr1411361ila.11.1598622446495;
 Fri, 28 Aug 2020 06:47:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmlJWiyrgOl59vPyxdQtRqJd5Qy1cE6Ha3PtfDBYLqotlZ/iOLYbiLSJtxfMqCKO3W/oTEOPsTHn2EcBMibaI=
X-Received: by 2002:a92:4f:: with SMTP id 76mr1411339ila.11.1598622446245;
 Fri, 28 Aug 2020 06:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
 <20200828110734.1638685-6-marcandre.lureau@redhat.com>
 <e3840569-5aa5-34f7-5962-7f63c51451ae@redhat.com>
In-Reply-To: <e3840569-5aa5-34f7-5962-7f63c51451ae@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2020 17:47:14 +0400
Message-ID: <CAMxuvaxos5RazRCEB9ce-7tqwAdAPh_jDLN8LgxxvXeaEXhK6Q@mail.gmail.com>
Subject: Re: [PATCH 05/16] tests: qga has virtio-serial by default when host
 has it
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Aug 28, 2020 at 4:55 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 28/08/2020 13.07, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > When dumping the default configuration, don't expect virtio-serial as
> > the configured method, unless the host has CONFIG_VIRTIO_SERIAL.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/test-qga.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tests/test-qga.c b/tests/test-qga.c
> > index 4ac4c22109..122730d326 100644
> > --- a/tests/test-qga.c
> > +++ b/tests/test-qga.c
> > @@ -728,10 +728,12 @@ static void test_qga_config(gconstpointer data)
> >      g_assert_false(g_key_file_get_boolean(kf, "general", "daemon", &er=
ror));
> >      g_assert_no_error(error);
> >
> > +#ifdef CONFIG_VIRTIO_SERIAL
> >      str =3D g_key_file_get_string(kf, "general", "method", &error);
> >      g_assert_no_error(error);
> >      g_assert_cmpstr(str, =3D=3D, "virtio-serial");
> >      g_free(str);
> > +#endif
> >
> >      str =3D g_key_file_get_string(kf, "general", "path", &error);
> >      g_assert_no_error(error);
>
> Does this work as expected? I thought that CONFIG_VIRTIO_SERIAL is a
> *target* specific config switch, not a host specific one ?

You are right, it's basically dead code then. I'll drop this patch for
now, or come up with something better. It was from an earlier attempt
where test-qga was running under !linux. I will try that again.


