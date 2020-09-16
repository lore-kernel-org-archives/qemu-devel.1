Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779A0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A6920732
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITPmYmUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A6920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaMR-0008GO-GT
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIaKe-0006vA-A2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIaKY-0001YM-Rl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600273844;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Q79iL6esAeHPH+Xsc3oGIUlFk5qdmvEwHXl8raDgRA=;
 b=ITPmYmUZjygiYpm4U4ZEtBVoMA3/XOPg4JSdLhIkUdVHlpC4jCnUZ5+DFEUfmkjgbFhJJd
 7LIxsqsecjNGLNu1NthLycssSm44cFWC8TC8MdUabI3GcsIXSDefuGYch/tvXP5A/GKGm0
 0wi3CDI3HFBdjg+l+KzHnberfON/q+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-aKZO0DU1M6qAbDN9fnMtHA-1; Wed, 16 Sep 2020 12:30:37 -0400
X-MC-Unique: aKZO0DU1M6qAbDN9fnMtHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D295801AED
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:30:36 +0000 (UTC)
Received: from redhat.com (ovpn-113-248.ams2.redhat.com [10.36.113.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A8805DEA7;
 Wed, 16 Sep 2020 16:30:30 +0000 (UTC)
Date: Wed, 16 Sep 2020 17:30:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH] hw/nvram/fw_cfg: fix FWCfgDataGeneratorClass::get_data()
 consumption
Message-ID: <20200916163027.GS1535709@redhat.com>
References: <20200916151510.22767-1-lersek@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200916151510.22767-1-lersek@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 05:15:10PM +0200, Laszlo Ersek wrote:
> The documentation on g_byte_array_free()
> <https://developer.gnome.org/glib/stable/glib-Byte-Arrays.html#g-byte-array-free>
> says:
> 
> > Returns
> >
> > the element data if free_segment is FALSE, otherwise NULL. The element
> > data should be freed using g_free().
> 
> Because we currently call g_byte_array_free() with free_segment=TRUE, we
> end up passing data=NULL to fw_cfg_add_file().
> 
> On the plus side, fw_cfg_data_read() and fw_cfg_dma_transfer() both deal
> with NULL data gracefully: QEMU does not crash when the guest reads such
> an item, the guest just gets a properly sized, but zero-filled blob.
> 
> However, the bug breaks UEFI HTTPS boot, as the IANA_TLS_CIPHER array,
> generated otherwise correctly by the "tls-cipher-suites" object, is in
> effect replaced with a zero blob.
> 
> Fix the issue by passing free_segment=FALSE to g_byte_array_free():
> 
> - the caller (fw_cfg_add_from_generator()) temporarily assumes ownership
>   of the generated byte array,
> 
> - then ownership of the byte array is transfered to fw_cfg, as
>   fw_cfg_add_file() links (not copies) "data" into fw_cfg.
> 
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Fixes: 3203148917d035b09f71986ac2eaa19a352d6d9d
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


