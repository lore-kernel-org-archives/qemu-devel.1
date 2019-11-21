Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB3C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B54B2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jby3pZbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B54B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlG1-0003Q2-Gw
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXlCv-0000FL-NQ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXlCu-00081D-IF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:05:09 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXlCu-0007xy-Ah
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:05:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id g206so3161622wme.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vkbc4EaaPPNklPpPrxrPo7vNcXH2XKi9AJPnSujmXvw=;
 b=jby3pZbZBApLcCJGjMWvjENA8DkWIoDpFnLlb6u9Nsyqrik5DPbB9IQDwAtVwfPZ9E
 eMTqZ6tBqUk1rFeO7oyvEmrXT2s/qtEZKYnQpDCDHJUcDE7JeNJUdLb+FN1yRfggbPc3
 aEG2HjjXckSaCgRIYWo9DmrHcvDafoZxM8DgKcsp7+DNkbZf9XOvuG0TpKRvnOkDtBhj
 gvgAn1uvJQaQU9Imv8AcjQpVenhpGBogPTcYMUybIzt9r2PF8wq6FDgZWs77uNZpfVFj
 cLUH3aLi3RMg/YhkgbG/xZnB5OwX4uFXSFoORf2fwLdJzkQm7GsA7qkoLl68NliXCqmu
 5Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vkbc4EaaPPNklPpPrxrPo7vNcXH2XKi9AJPnSujmXvw=;
 b=dtIagYaHn3EAUTWji+2trg7riwn/QebHfmfYjeHiDETuSzZAAWMhpCVDbskqPrL4La
 F64Zi6ZbKPZKkI1cLukNcIuy9AeFoyjKcGtMMI0u26uDknNjznG0lFcruv8cWYn88Neq
 b+FcCCnznpuslSYY8xg2ZJovrGmyqJsQLxcW2yfnWwoRh4HhI+qXeYFD+SAmZtS4dKV9
 cHKCbnMugewF8Br8ntcMvdeQs9xIePv2O7iN84aL8edPQUfvEBhYs+UcwiiKbFYaaTE6
 Tk9slfRlvmRVkOi5wofo97gYLOhZWSWNiZtoJ/6f5gdhnQOI/XEUf+eN39gKIcmxZakx
 LaCw==
X-Gm-Message-State: APjAAAUp6uHVyCsk97oReHTMxuB+0EbVYpNHS9Jgveu1GoJ7+LnsRemo
 7/jMW0ASa2+ikHpW4PtNZgc=
X-Google-Smtp-Source: APXvYqwFhE3thlvvXrrwhAIUNN2dtcJf3+cEpCJMdQrw74CI6Am4A9EP16NdUX131fgDDSy963WNAg==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr9671496wmg.45.1574337906753;
 Thu, 21 Nov 2019 04:05:06 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s11sm3004901wrr.43.2019.11.21.04.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 04:05:05 -0800 (PST)
Date: Thu, 21 Nov 2019 12:05:04 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 19/49] multi-process: configure remote side devices
Message-ID: <20191121120504.GN439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <f36f81254336de4efb71b4869bd3c9e02d328392.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6o78gXsyQHm68LY/"
Content-Disposition: inline
In-Reply-To: <f36f81254336de4efb71b4869bd3c9e02d328392.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6o78gXsyQHm68LY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:09:00AM -0400, Jagannathan Raman wrote:
> +static void set_remote_opts(PCIDevice *dev, QDict *qdict, unsigned int cmd)
> +{
> +    QString *qstr;
> +    MPQemuMsg msg;
> +    const char *str;
> +    PCIProxyDev *pdev;
> +
> +    pdev = PCI_PROXY_DEV(dev);
> +
> +    qstr = qobject_to_json(QOBJECT(qdict));

qstr is leaked.

> +    str = qstring_get_str(qstr);
> +
> +    memset(&msg, 0, sizeof(MPQemuMsg));
> +
> +    msg.data2 = (uint8_t *)str;
> +    msg.cmd = cmd;
> +    msg.bytestream = 1;
> +    msg.size = qstring_get_length(qstr) + 1;
> +    msg.num_fds = 0;
> +
> +    mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->com);
> +
> +    return;
> +}

--6o78gXsyQHm68LY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WfW8ACgkQnKSrs4Gr
c8gYBwgAkPvk+VuQ64HojuuUOnIGeAVvSUuNEkUu0kcFvm6TkNbDliiHmEiJAMPC
GD5+f60FKqsm/xf4eU25MHwZh0GofjJHjUQnA0tVmg/wSNWaDtF2zjgcVRY2FLAT
HwO5uIOA3RYNqbYRl1+tFcmz4eoUSvaoHe86j97qCX6fnoHJkKcUq5uWiqr6sA+a
FwHyfoZ61eU0KAqVISCciqVJzK0FM87h1JILY0YUzyBjHxkK3ykvdU14KRoDqPry
Ud1FOAJtcititVPxZhRelHx7Ltzng4hpPJ9QE6YO8NOVnqdZm2jPMf5ydEMFhO7f
Xl/ZTG/YojmGMbM2vq24ek71l5FRsA==
=COoX
-----END PGP SIGNATURE-----

--6o78gXsyQHm68LY/--

