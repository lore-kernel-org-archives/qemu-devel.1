Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821EF20578
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7Q3K/TZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821EF20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joO9Y-0005iF-RH
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1joO8n-0004tS-S6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:25:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1joO8m-0003Fq-4l
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593077151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gauuXR/6WLIy/qa8A41WUgRox779IPtDLWVBC4EmmmI=;
 b=I7Q3K/TZKxuG23Qqt6HFk1WQmiaNkFAvLnyQWHt70EIyDVOvtzpipsTnNvbljjmHfbkp12
 TD6WroFvw/wHOXWJzzoZ7Z8rEji6cHgFlQ8udfJyPYAAMRsGo2bENPEQ/eU2VPmuurJK+i
 noT3GFrXOqeGfaVy2qL/mZv+FLHwXnk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-JK1kpoP5OJCqmWGUZJOVQg-1; Thu, 25 Jun 2020 05:25:47 -0400
X-MC-Unique: JK1kpoP5OJCqmWGUZJOVQg-1
Received: by mail-il1-f199.google.com with SMTP id i7so3681374ilq.16
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 02:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gauuXR/6WLIy/qa8A41WUgRox779IPtDLWVBC4EmmmI=;
 b=BM2DXVdJ5QEaUhqGEHUh4djJz3C6hmypf7HcOR/3bvVbjocRUDiOrjWmmx2ewFzTE9
 edz3QBJvmN4AD1NnClUmPu9POIe9AL2gXzmkXMTa0hJ6sdc4Cu+m5edLKcLdwPT8R7g2
 ZMLwOSPyPX+poHCZqvkQw4Cp5E4Qq/HaavKxvZqBloLTxr+/qNIxdv6sFCz8pguALMl2
 M0BvxqOmavRvL85QUYT1cml+b53T2ppBPH3hYwrpV6yvy74uQWgxzQXvIXLArt0lRBL1
 N7zdUS0Y9+Er4mzJmNh2q6EeOv5q+t2ZOkkHFsZmLZvmJuQNZHgEtg96IiD5cqERS8By
 Tw2Q==
X-Gm-Message-State: AOAM530iZycs57/RJdHiH0PEs52tgQYM9vbIhDDqt4Rrx4Sqj4SdMw38
 su8ImBCUBwA+kOvVCQUfiw8xegn4+g+Hp8Y6aNcr5cm7cc9jHlKBZSLlvKTbecrH/qoydQP8aTV
 KjE5cqAZzYNy9GF5xSodKH5SF7KZ0/5c=
X-Received: by 2002:a92:79cb:: with SMTP id
 u194mr12657038ilc.161.1593077146566; 
 Thu, 25 Jun 2020 02:25:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRn6/oYJA2UJgsuW/m45yAQ+DVx+2skl10fEMi3JhVEYAejq2v5KmLVpP+tXZjxFsu4xXnnnfW517yEOo0oe0=
X-Received: by 2002:a92:79cb:: with SMTP id
 u194mr12657023ilc.161.1593077146345; 
 Thu, 25 Jun 2020 02:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200621213017.17978-1-lichun@ruijie.com.cn>
 <87pn9n3alv.fsf@dusky.pond.sub.org>
In-Reply-To: <87pn9n3alv.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 25 Jun 2020 13:25:35 +0400
Message-ID: <CAMxuvay1DnoogVOCxffYe4aA7sX8vZi6CoEa_j2kjWN22n3xAQ@mail.gmail.com>
Subject: Re: [PATCH v2] chardev/tcp: fix error message double free error
To: Markus Armbruster <armbru@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, lichun <lichun@ruijie.com.cn>,
 qemu-devel <qemu-devel@nongnu.org>, 706701795@qq.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Jun 25, 2020 at 10:47 AM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> lichun <lichun@ruijie.com.cn> writes:
>
> > Signed-off-by: lichun <lichun@ruijie.com.cn>
> > ---
> >  chardev/char-socket.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index afebeec5c3..569d54c144 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -142,6 +142,8 @@ static void check_report_connect_error(Chardev *chr=
,
> >                            "Unable to connect character device %s: ",
> >                            chr->label);
> >          s->connect_err_reported =3D true;
> > +    } else {
> > +        error_free(err);
> >      }
> >      qemu_chr_socket_restart_timer(chr);
> >  }
> > @@ -1086,7 +1088,6 @@ static void qemu_chr_socket_connected(QIOTask *ta=
sk, void *opaque)
> >      if (qio_task_propagate_error(task, &err)) {
> >          tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
> >          check_report_connect_error(chr, err);
> > -        error_free(err);
> >          goto cleanup;
> >      }
>
> Since my "Error handling fixes & cleanups" series fixes similar errors.
> I'm happy to merge this patch along with it.  Up to Marc-Andr=C3=A9.

That would be great, thanks!


