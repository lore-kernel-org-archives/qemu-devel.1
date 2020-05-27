Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409EAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0347320873
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shHXWZGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0347320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdvZb-0002Fy-7c
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdvZ0-0001pz-4x
 for qemu-devel@nongnu.org; Wed, 27 May 2020 08:53:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdvYy-0006CR-Ua
 for qemu-devel@nongnu.org; Wed, 27 May 2020 08:53:41 -0400
Received: by mail-wm1-x343.google.com with SMTP id k26so2455547wmi.4
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QweQOQPt3l23cOA2D5COGDGvxA7nMiAps83e6QMB8Lk=;
 b=shHXWZGVGvgbC6cl2jmzK0gYQo4jjS4y6BXj/Ggi4cjBZ+1vN1C7wv8YzoIKcnoour
 g2sTI3xeKkuQsXxLpIQN0XYvxrn/xViOlcEZbW+duMlK+1HJk8GMbVoIn+vo7nidJ4J9
 zMp/76coxL3xndoI1iwbDy3qzSh3yiPtOhwrAhgjJpZDJXAs/+zaJppPDbkGms+W5uHN
 f6cIYY9iCI3QrG8YtntQUPh4K6G239hNbCB1/yGtAqm+g7Rw5oPKHsoUXTGkOcvFn0Bb
 UddlgEaCVOSjoOrBaqhAC/wUr26ncib+smduLJ9EjCTVc+cy2RYDqQnMWRMpME9VFJZ7
 RkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QweQOQPt3l23cOA2D5COGDGvxA7nMiAps83e6QMB8Lk=;
 b=RZ+GkuUJVGAu10cPutUwIS69YjhxyDBX2LzEbZwRvqON0Xiuf2BQwG+MQhxUuYrsQn
 71lry9tyhuxgnYVYHSc9j6qRuuuPPvh2oepmD6QNgsi0yGnPgX9je/WcbyIqFr9gbU9A
 0luYl4v/u0ltwTs0jrRhM70Ux9/AwcQ7KWM5vhdmowW1SOPQkRNS4Fa8oM7AusIejPz1
 35lGi1+YZFEAPDqSXqB+HWb8Hc40f9P6iiqvWBWIas7jT/KU0haSNK5ME6D5LTbKFZCA
 nq5JkJTX3bGo3zOFbxjhWg5RoYJqnH0wxaBPQ6Zoq/S+RRxMe4uVuD31GtKg3JBHKqRU
 +mhA==
X-Gm-Message-State: AOAM530ouLjIt+bMTdC4I6VOFVG+rcymN9Q87m3Bq5j/oM0W+Jb8ZpIU
 5ny4ANx3SnnVnDpDnIY4ey8dgQECzj4=
X-Google-Smtp-Source: ABdhPJzXCQjCB+3fSSCDPS3AXefmOGpFK52U6aM+Q5vrl0BQzepaeSWHCfgKnGdzlgp6Foj0iTw3Mg==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr3990529wmj.2.1590584019568;
 Wed, 27 May 2020 05:53:39 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p10sm2862196wra.78.2020.05.27.05.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 05:53:38 -0700 (PDT)
Date: Wed, 27 May 2020 13:53:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 1/7] scsi/scsi_bus: switch search direction in
 scsi_device_find
Message-ID: <20200527125336.GG29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-2-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Content-Disposition: inline
In-Reply-To: <20200511160951.8733-2-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 07:09:45PM +0300, Maxim Levitsky wrote:
> This change will allow us to convert the bus children list to RCU,
> while not changing the logic of this function
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/scsi/scsi-bus.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OYtAACgkQnKSrs4Gr
c8hR+gf+PCN1vm4oPbh0mYOCCftaWszZgufDcic59QYZOp1+Mjm/Rh56ju1aDUaN
0KJSlOiA7mwRG94OBySIDci7lcvW8gwbXiuTvdar9TlRt/mw5InED0FOQVqsmVin
CMb0+uyhgMzE5eDIqFECYOrjOiECQ4TEBcMevMUgsDrvFV4/J0tkv6GEJpsCqN6Q
Tp55FWG5hP/Ru8DrqxT04+zv5DTJmsqc9jMANYuYM2FihhvSIkzODlebgo9Lyby/
VJC+P8qjjABxvUaaHDxFkw4/HKSyFp+WXveASbgg8f77jwMOCI+CwXaNtN9h9tIK
doqzXG8FQZ1LpjnhBKaEWLwOB7HgUA==
=UzGI
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--

