Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DFFC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0160021D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/iDTVJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0160021D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdtB-0003BM-Vf
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZdsR-0002jX-Ho
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:44:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZdsP-0002EE-K1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604339056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mjb6H4NvyFHwpcg6nWQkjOVtTi6BK+5QD1S2qqHl7Y=;
 b=A/iDTVJ1ejvDgUOcPi1hlM7922rzJc5/+I+UTHDrunlJ5sWlMZsW53V54PSkNeOU2gdxzf
 pqd0j82zS5apky44X+zeSemIf177beWws2VzS3V1VxvR6/C50FKa8tiimNe4hAwoVQBsZm
 TrMQhkXYbLH0FSmt6hMU+Ppe02Aejc8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-QUizQ1shPhuplw2wHX4znw-1; Mon, 02 Nov 2020 12:44:14 -0500
X-MC-Unique: QUizQ1shPhuplw2wHX4znw-1
Received: by mail-wm1-f70.google.com with SMTP id o81so1045892wma.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9mjb6H4NvyFHwpcg6nWQkjOVtTi6BK+5QD1S2qqHl7Y=;
 b=Itr+fVjpVVT3E7nZFy5A9giZwvpROQPodPSodhHbe6M+JCTPMqLucLZp09yOFm8Lfm
 pQQTupcfVkcQ6MMkME78pqQ8YRy8qFpbqtxGaGcDQKzIFkrZc4XfemaCThMx5EaTw3Ln
 iCpLWvGlg7BECSF8ZU9Z0+bWmP9NHiugkPfC9n4Ts9+fLFuYu4WFfgp6QaqgEeaVNsxO
 2YlxjqkCMnFPxBAAG5dEC1fl6taPd1KerG6OZ9gAtEM4bGjSf/4vEnrhuKKbF9gJ5IpF
 cbfdFL7boJby6BE+6rQz+63/HcTE3FRZCs1m1KwzuSILZwcne/awOJtB6v2mjkIa790S
 MK+g==
X-Gm-Message-State: AOAM530aBHv6Qv3HrJi6Tmley0UtTI+NW8I3zu0IPgcSr7HC7o3n9L75
 cLf3Oj0GY0Or3tx0qyj4Va9k4LvluX7yseRg6a78MUVilmWRVaiN9rjHuM6Q40Dv4ftqKMR2n7K
 rPz0i2hyKptpw/wc=
X-Received: by 2002:a1c:f002:: with SMTP id a2mr20014009wmb.129.1604339053390; 
 Mon, 02 Nov 2020 09:44:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdLo027Smfk5ZwfQjFGUAAtWi6PpifENT1CqY5UzqmAK/xlz4YJL0xXy4W4SK/cLju+csBiw==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr20013992wmb.129.1604339053147; 
 Mon, 02 Nov 2020 09:44:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id d3sm22318427wre.91.2020.11.02.09.44.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 09:44:12 -0800 (PST)
Subject: Re: [PATCH v10 10/10] vfio: Don't issue full 2^64 unmap
To: Alex Williamson <alex.williamson@redhat.com>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-11-jean-philippe@linaro.org>
 <20201008152214.3cb1425b@w520.home>
 <20201030062513-mutt-send-email-mst@kernel.org>
 <20201030112622.0edaa660@w520.home>
 <49788b62-ee5d-0b6f-36ff-3c2ba144df39@redhat.com>
 <20201102103723.71fafca7@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf320b8e-d3a3-ae69-69ec-405bb58948ed@redhat.com>
Date: Mon, 2 Nov 2020 18:44:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102103723.71fafca7@w520.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, eric.auger@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/11/20 18:37, Alex Williamson wrote:
> I think we still have the issue at the vfio ioctl which takes __u64 iova
> and size parameters, in bytes.  Therefore we cannot unmap an entire
> 64-bit address space with a single ioctl call.  We'd need to make use
> of a flag to modify the ioctl behavior to work terms of some page size
> to achieve this, for example if iova and size were in terms of 4K
> pages, we wouldn't have this issue.  Thanks,

What happens to the last page if size is unaligned (e.g. iova==0, size==
2^64-1)?

Paolo


