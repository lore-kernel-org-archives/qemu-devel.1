Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29813C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96B92078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Utq9lZfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96B92078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxTx-0003pK-9P
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxTG-0003E1-04
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:36:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50153
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAxTE-0007Nj-CN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598456175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZro7NJXjkTK2XuqU/dij4OqW/NO2BJCl/amibXhdrU=;
 b=Utq9lZfQsJ5DIwf7y7ASa9+YSP6yLbANiy5q55LYgQMnZwWPaqQe3MbZJP3oqNnJhbO/Pv
 hO7r7yFjrVFTB31wFGVzi2g7qgJqg6uIt0tmWhbW9C7o+VjzdHQIfd+n1ZmcK1/KMdnmDg
 vpb/5xH3siTeJM2nThc/NfVJZsSPsRI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-xaR6tHPON4SfnpNqdO29Ug-1; Wed, 26 Aug 2020 11:36:13 -0400
X-MC-Unique: xaR6tHPON4SfnpNqdO29Ug-1
Received: by mail-ed1-f71.google.com with SMTP id f1so500862edn.5
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VZro7NJXjkTK2XuqU/dij4OqW/NO2BJCl/amibXhdrU=;
 b=S7SLsr4GBo9b54BIhu2LYwQ/qAwjkjgoqbRSUL80xQIMTMqF3onbEPC6NjMHnhDgs/
 mz06gJumL8M8lZS7hVwsO7TP6bTaMlYwp5sOyJT2L0P5gmfxUKZMe5YLt/r84zozdN69
 A1MhNTVw8610DnqReEwRs2aIxR6Q+DmWEVz+1UFfflI+PIGiSmteEzy1QDvyeCqLtSPG
 ZUBeGdSbQxOkDWcT5emQ9wrI7ND1Kq9I1+Pl4RbjKHgVBB5+MtVMXoaVuw3ONhPyJIWO
 upGjynv0+4V8qPvKQn53PAyquPInsewVaylHTpkU2158xse4+uIntbdphV2/Zz6061zF
 qS0w==
X-Gm-Message-State: AOAM530sq5+ejFd/g1Vp588rZEIMwVR4OK1vpYA6IoM7pAMeRLyZmaqJ
 jepkpp5vunFCDAJyiLwsGcfQj49juTinREUO4cmqF8s4IEYqbJ3fDCqqPO8GY/B/WlUEMnGrTv1
 wCzNKudy5QZMMmkWMhM7Yd7YyGKCastI=
X-Received: by 2002:a17:906:d9db:: with SMTP id
 qk27mr15385125ejb.230.1598456172409; 
 Wed, 26 Aug 2020 08:36:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXXPtr7gjMZhu74calNUx5WMGYTIilfEXTNbEi51PXnDkfa0tGu6AhkHqW80mcAmY/zu32zbtACqSP6XCEC8Y=
X-Received: by 2002:a17:906:d9db:: with SMTP id
 qk27mr15385109ejb.230.1598456172240; 
 Wed, 26 Aug 2020 08:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <20200826151006.80-4-luoyonggang@gmail.com>
 <CABgObfbL9rdB1T0gzYvT4uR9D8ghLmo7OYaVdk+Vdk_vSjjvoA@mail.gmail.com>
 <CAE2XoE-mG9PFZF3hA4XpZ62oUicMQDid5AMqvUbx+yoOfLY=EQ@mail.gmail.com>
In-Reply-To: <CAE2XoE-mG9PFZF3hA4XpZ62oUicMQDid5AMqvUbx+yoOfLY=EQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 17:36:01 +0200
Message-ID: <CABgObfagsQcHhAFTfDcqH5hWOzrwuHocygu10uWO7XR8BPmyEw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] configure: Fix include and linkage issue on msys2
To: luoyonggang@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:09
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 5:33 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <=
luoyonggang@gmail.com> wrote:
>
>
> On Wed, Aug 26, 2020 at 11:24 PM Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
>> I'm a bit wary of this patch, the effects are quite wide-ranging. If
>> we move all the detection of dependencies to meson, it will take a
>> while but we should get a similar effect.
>
> Only on MINGW the $PWD sematic are changed, so I don't think there is sid=
e effect of this patch.

Yes the side effect is only on MINGW but the affected variables are
used everywhere so it's a rather hard to review change.

Paolo


