Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160D7C3404B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D680D2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xde7mpV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D680D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4B5w-0006e5-16
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 17:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4B4J-0005pU-JK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4B4H-0007lP-Qe
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:10:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33557
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4B4H-0007hz-MZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582063812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAwZk9nDwcXm79Pi12LerLUXo8ddE+CnAMw0D3AdPM0=;
 b=Xde7mpV0TPlnFfyHmIVgCDewXUibKWJyQMeyyu7exXenbMiH2yXeZPX12lR90UVedbKh3F
 idAzeoqPlxvzgW053qbWxC2LQ7Nn+iPK3Xu+ll5bVCcjTaK+hha6cceVn8U+u9sMpo1NAJ
 Rl3KZAEP329FfxtlNzret+RuXaheCdw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-vzyyKNSLP3uJx4owvPElhQ-1; Tue, 18 Feb 2020 17:10:08 -0500
Received: by mail-qt1-f200.google.com with SMTP id k20so14113417qtm.11
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 14:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kzEFM5YRZtSjRm/IjxqsnPD7eXKQldyKuafonznPg34=;
 b=LNRdmJHME+rLljX7ULEMdVoDjlFrC6Vumw7DkguDRTbFVpcgO1jEJlw6YGLDtirapD
 7R4/Mpb/41mC0SpYbm0Nl3ehBEezeb2i+OKx18lb3MFG2fTAwgAXpDIl7nuvyJN5GNa8
 hW8AyFjJR8KGNgi5IfEpWfsIU8+F3koGfHhNb/eYev0ii4nr+uvlMYoMyTEVJUrqLPMV
 qvlf3FQlL3jF9WqoyRdYUHOr8EdxCMA9EfFcp2558OHumDPDHm3+3FKqlJq3gaGtgLRB
 DIu1UNIOw6iB7Xczhm6Lfj72lS6SPjeHG3xXmA9N4MxRF345IxinQ55mZpG7Qfh6Ly2y
 0X3Q==
X-Gm-Message-State: APjAAAUoqeVabp6ZO+eE2pUsMNf5QFSM58I/XknHMax4aL+D0ssPxIpR
 6bsPUpODu1rKtit4PRZZgJtB0m1E7YoKLLaWUC7HZY3/WZNFITa6wDcVYrbj6TgJJF1Cbq5NyPq
 B8JF7XJle/3YGSy8=
X-Received: by 2002:ac8:7352:: with SMTP id q18mr18992576qtp.125.1582063808449; 
 Tue, 18 Feb 2020 14:10:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEsCu4IwCIXglxQNTe0WzhOGnq+SwgGjmuE1vidbkm0BWikBY8kCW/aUrfRjJfLEEBPXlivw==
X-Received: by 2002:ac8:7352:: with SMTP id q18mr18992564qtp.125.1582063808250; 
 Tue, 18 Feb 2020 14:10:08 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id a72sm2634192qkc.121.2020.02.18.14.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 14:10:07 -0800 (PST)
Date: Tue, 18 Feb 2020 17:10:06 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 04/16] util: vfio-helpers: Factor out removal
 from qemu_vfio_undo_mapping()
Message-ID: <20200218221006.GH7090@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-5-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-5-david@redhat.com>
X-MC-Unique: vzyyKNSLP3uJx4owvPElhQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 02:42:42PM +0100, David Hildenbrand wrote:
> Factor it out and properly use it where applicable. Make
> qemu_vfio_undo_mapping() look like qemu_vfio_do_mapping(), passing the
> size and iova, not the mapping.
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


