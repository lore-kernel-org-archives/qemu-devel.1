Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66763C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382E121473
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYKvQqQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382E121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5IE-0004Ex-9y
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX52b-0001b9-Gn
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:35:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54082
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX52a-0002LY-Ms
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588952156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOwpfHZ2y3t/2qkYAIbonjx8jp14b1DhX3gxwWkc4O4=;
 b=TYKvQqQdj7KL5QhM8NpshACECzLkwjYCcro79i+ySY+nwr4lJFhHJrmQ1JrRaCKDSTbFvb
 marBGeG75BMaY9ylZmRUeS/oEphQELZuBpY39LdN1gjXH6rdGjJhwTdWbbkXgo8dM6nnWd
 8pI8JzyHtzdarrixgj+c5AkEvwQDcbo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-OYLuz_XON5iRW53Dis2msw-1; Fri, 08 May 2020 11:35:52 -0400
X-MC-Unique: OYLuz_XON5iRW53Dis2msw-1
Received: by mail-wr1-f71.google.com with SMTP id f15so1071788wrj.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fOwpfHZ2y3t/2qkYAIbonjx8jp14b1DhX3gxwWkc4O4=;
 b=TQH+J/C/Zy4JMGl9Uy98bNxhxiuF9Le3AXpl0hbkLUgLKD8XtZ7tqbFXsyWuit9QXE
 //4E7wUwtaA3M547/nku8LPwva6mOFwnbu67RFLRMAIWW+BjisJQzbwHN3B96rjdL7rC
 Uw7s2Fx2ijwQbVl2GmADyr3GizsH+58ILDPpqnm8wSZ+V8IucCM+L+1CiprOiq4XKejZ
 QUsoD3YOFFlNqLWRZc5nYQm2V24ZjKebXhy5vDgfDuuX3rf1KqOSEZhq3LyvZE+cVG+B
 zNOThs6yKI+3CT52HGqLKqE5pdf0jswKBX+D2sWJoC2YfvotUYmJ4v4PSYBHfZOegqHI
 dcmg==
X-Gm-Message-State: AGi0PuYiMKXhpnIijkjidhxqwQsYpamUcvrus5wBTn7s/cPhB8jCSzjD
 p9BaTNFR1nYu5HAcN1DduBuDfNBWJYfw1rTKmJk4mF0KEffjuJollrTWUeOWdSn6ic8Ks1E55Vz
 WVrmMPjsns3CBLwwjoJdHtJKmcsn7IWI=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr3372911wrp.427.1588952150953; 
 Fri, 08 May 2020 08:35:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypJxe/3NZMJPAOEEZb5BJ/pWHPdvNNd+m61KhPr/t5EY5CD2AanPYHlN+vPyLcJ7FT9gEEN3N/+mJN+MNov1CTM=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr3372893wrp.427.1588952150678; 
 Fri, 08 May 2020 08:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200508062456.23344-1-philmd@redhat.com>
 <9396e0cb-388a-e08e-c066-82a60708ecdc@redhat.com>
 <CADSWDzvECqOXzusk=tj8r4z-E5CDZn4TNG8PJ5pxLHAn3saOzA@mail.gmail.com>
 <500bd6f3-2b14-eda8-72e5-56c46b7860bd@redhat.com>
 <653758ab-468d-b6f8-0ca6-404a799e3928@redhat.com>
In-Reply-To: <653758ab-468d-b6f8-0ca6-404a799e3928@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 8 May 2020 17:35:39 +0200
Message-ID: <CAP+75-W=DVYQuh0bVMRdo=mK8nLA=4VmsjJfXfO+TBwBj+aw0A@mail.gmail.com>
Subject: Re: [PATCH 0/4] memory: Add memory_region_msync() & make NVMe
 emulated device generic
To: Paolo Bonzini <pbonzini@redhat.com>,
 Beata Michalska <beata.michalska@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Keith Busch <kbusch@kernel.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 8, 2020 at 5:34 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 5/8/20 5:33 PM, Paolo Bonzini wrote:
> > On 08/05/20 17:20, Beata Michalska wrote:
> >>>
> >>> mr->dirty_log_mask tells if dirty tracking has been enabled, not if t=
he
> >>> page is dirty.  It would always be true during live migration and whe=
n
> >>> running on TCG, but otherwise it would always be false.
> >>>
> >>> Beata, can you explain what you had in mind? :)
> >>>
> >> It has been a while ... , but the intention there was to skip the sync
> >> if there is nothing to be synced in the first place - so for performan=
ce
> >> reasons. I honestly do not recall why I went for the dirty_log_mask,
> >> as that seems not  to be the right choice .
> >
> > You probably wanted to look at the dirty bitmap, but you would have to
> > define a new bitmap rather than looking at dirty_log_mask.
> >
> > But that's cool, because it means that we can just remove it!  Thanks,
>
> So I understand I can simply rename memory_region_writeback ->
> memory_region_msync in patch #2.

(removing the mr->dirty_log_mask).


