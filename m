Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9CDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DF5206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yu9houKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DF5206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRnP-0000UY-FL
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joRmW-00083S-II
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:19:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40752
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joRmU-0001cr-2q
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593091145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFthI0jcj/bqotuhJDNqFBAMjMi82JrfhynUFova9Nk=;
 b=Yu9houKCDjxk9SRXIYwGnBqdXEZ0zwlMXFBqK1r5CEPXIciwq7dE61fstvlxyIzAvslXEf
 4JqDgAlopDj8Ekr5Lq8px4u6pbtSmSwT9FDDpB/DpWfnQdUfgEWcGxGO7VjuN/Op95RbHf
 YKdsS5NySA3ZegOPfc7Fra48JhlGqpw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-V3R14okYPwSFy4ifnFJQEQ-1; Thu, 25 Jun 2020 09:18:56 -0400
X-MC-Unique: V3R14okYPwSFy4ifnFJQEQ-1
Received: by mail-wm1-f69.google.com with SMTP id s134so6973818wme.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VkalzHMM0z/9debK//2BU7PWJdxagXlgPZ56FmOdaqE=;
 b=kn5JQEFuKKTDO+4cHdd/UCxjseqom3KMN3D5gMrVJWdJK9eJLIVHYO4AlhX/Us3OwK
 gkvV1X2dr6HrijGeV9HTzdh3o0Gn0rLdR57fDPxt3ErBMiKhC+fkKRzRYBCITHw3HNfW
 G48g+SrNVloZCh/xxUB+DFcXsLCt2XXrpiFe9CNpBWxajDKUH0EgXP84pCazht9B0HqK
 s7S0JIuI1HKDBss7i15MyxtvZfJUhHFKn00YJeWFKht22RoBIMNoShU60qhP75MM8ssi
 tgK3ofrfyOvEE9USFTRfb1inpY+BCj92I0X4e9LiH29O6KXTgHQXDKAtLDsQ/JVPrjcV
 hSyg==
X-Gm-Message-State: AOAM5301M+1SkdrJ0uF0Uos2Zo+WywlwkEk71RTajRxTtU9OezAza/Ah
 MwVw9kwhYLK/PI66YesvqS9TtrpW7S/1hE9kbRAOtxKlDziratxKK0DB9NqNhA+LhDlzPJzu3qt
 S2vCnGEN/WF6+ZVg=
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr3399241wmy.79.1593091135012; 
 Thu, 25 Jun 2020 06:18:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4OJmvJiUdW8cbVGE+AYf9+yx2JRP7PRLqQU2d1Dg0p9KMpt+Ci969d/5Ur2friyCYj1IBsg==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr3399217wmy.79.1593091134784; 
 Thu, 25 Jun 2020 06:18:54 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 e25sm32121043wrc.69.2020.06.25.06.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 06:18:53 -0700 (PDT)
Date: Thu, 25 Jun 2020 09:18:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/6] virtio-console: notify about the terminal size
Message-ID: <20200625091815-mutt-send-email-mst@kernel.org>
References: <20200624112640.82673-1-noh4hss@gmail.com>
 <20200624114915.GH774096@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624114915.GH774096@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: lvivier@redhat.com, amit@kernel.org, qemu-devel@nongnu.org,
 Szymon Lukasz <noh4hss@gmail.com>, pbonzini@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 12:49:15PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 24, 2020 at 01:26:34PM +0200, Szymon Lukasz wrote:
> > Also there is a problem with the virtio spec and Linux Kernel
> > implementation, the order of fields in virtio_console_resize struct
> > differs between the kernel and the spec. I do not know if there is any
> > implementation of the virtio-console driver that handles resize messages
> > and uses a different order than Linux.
> 
> Well this is a bit of a mess :-(
> 
> The main virtio_console_config struct has cols, then rows.
> 
> The Linux impl of resizing appears to have arrived in 2010, and created
> a new struct with rows, then cols.
> 
> commit 8345adbf96fc1bde7d9846aadbe5af9b2ae90882
> Author: Amit Shah <amit.shah@redhat.com>
> Date:   Thu May 6 02:05:09 2010 +0530
> 
>     virtio: console: Accept console size along with resize control message
>     
>     The VIRTIO_CONSOLE_RESIZE control message sent to us by the host now
>     contains the new {rows, cols} values for the console. This ensures each
>     console port gets its own size, and we don't depend on the config-space
>     rows and cols values at all now.
>     
>     Signed-off-by: Amit Shah <amit.shah@redhat.com>
>     CC: Christian Borntraeger <borntraeger@de.ibm.com>
>     CC: linuxppc-dev@ozlabs.org
>     CC: Kusanagi Kouichi <slash@ac.auone-net.jp>
>     Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> 
> The virtio spec documenting this came 4 years later in 2014 and documented
> the resize struct with cols, then rows, which differs from Linux impl,
> but matches ordering of the main virtio_console_config:
> 
> commit 908cfaa782e950d6656d947599d7a6c9fb16cad1
> Author: rusty <rusty@0c8fb4dd-22a2-4bb5-bc14-6c75a5f43652>
> Date:   Wed Feb 12 03:15:57 2014 +0000
> 
>     Feedback #6: Applied
>     
>     As per minutes:
>             https://lists.oasis-open.org/archives/virtio/201402/msg00121.html
>     
>     Signed-off-by: Rusty Russell <rusty@au1.ibm.com>
>     
>     git-svn-id: https://tools.oasis-open.org/version-control/svn/virtio@237 0c8fb4dd-22a2-4bb5-bc14-6c75a5f43652
> 
> I can understand why it is desirable for the resize struct to match
> the order of the initial config struct.  I'm guessing it just wasn't
> realized that the Linux impl was inverted for resize
> 
> The FreeBSD impl of virtio-console doesn't do resize:
> 
>   https://github.com/freebsd/freebsd/blob/master/sys/dev/virtio/console/virtio_console.c#L874
> 
> Not sure what other impls are going to be around, but I feel like
> Linux is going to be the most commonly deployed by orders of magnitude.
> 
> So I'd say QEMU should match Linux, and the spec should be fixed.
> 
> 
> Have you reported this bug to the virtio spec people directly yet ?
> 
> I don't see an issue open at
> 
>   https://github.com/oasis-tcs/virtio-spec/issues/
> 
> so I think one should be filed there
> 
> Regards,
> Daniel


One reports defects on the virtio-comments mailing list, issue tracker is just for
tracking spec changes.

> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


