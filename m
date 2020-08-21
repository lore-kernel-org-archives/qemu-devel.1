Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7309CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE1B2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkiwKWPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE1B2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96dI-0002ap-I7
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k96ce-0002Aa-GV
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k96cc-0004Te-Fr
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598014697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bq/ljcc6YItIYAmsgMRKTODv0741Lr8mvM1tUZfeha8=;
 b=IkiwKWPzYyYJKawnTDj5kAw7XpzvlVYxFvnNiKtg2kKOtzLIiS88EBebwzHB9/Q6/WZ8/0
 9GHfmPDuWqH4OZQIXZ+86L/7fHCyNiFRDRFulIkDnOG4lsQHQD3mTTbOzA/+IZw5v+t1p7
 VFTvDaAdNK01B0eYesYmlYbUKPyQGNM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-TVlUeR5tPgWmX3z78m5HRQ-1; Fri, 21 Aug 2020 08:58:13 -0400
X-MC-Unique: TVlUeR5tPgWmX3z78m5HRQ-1
Received: by mail-wr1-f69.google.com with SMTP id m7so523964wrb.20
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 05:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bq/ljcc6YItIYAmsgMRKTODv0741Lr8mvM1tUZfeha8=;
 b=PPfVputFykpTKAyb1DcCiPHiBAlC0EGtu2wirdGqx5MFa+kNPH1ZFiO0itZHd8hdyR
 5uO/DAMWWh/KgHfw2gVpfLu3WLVoXqgXC2tM7UtvOmBG7JGa8RvS4HrDV57TeGd5ROKP
 wN53B9MQShiVbxcOSGeGwQzBGyjORhpp+nKzjvWMBTO1FmXwAH/DdpRIkYhiMcGcSHh5
 wV52rykOubVQqFymRATsgjI93auQLYh7zsEygM9iqtad/fr0saCFOg2wK9CSz60w7d2s
 syG3T+7LxkfM5V0dmlqkwOQcfMwLx2B3Y3hwU8rWTjiPKCDr94xQ00Jh9lASLZ4pIjw7
 +tjA==
X-Gm-Message-State: AOAM530BTiZEVa7ElstK0GptCU0kzLTkAcoGtlLEoKOE1sVsiSckPr2c
 DmyPXoNDcw+t15+9IHbLGYFDsGEidkS1JHRciy6iHWs0MFeQ0K+hQhGb/GN5ATyQJdsiobFkBvY
 nooh4zzZgddvPGqw=
X-Received: by 2002:a7b:c195:: with SMTP id y21mr3084716wmi.20.1598014692522; 
 Fri, 21 Aug 2020 05:58:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyit81WMW51MJlUCcfMhAJST+kbXfaAVRn81fQqbJCkUikhxFyHBrcyf/FOkOMrPzICyXUiwQ==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr3084696wmi.20.1598014692256; 
 Fri, 21 Aug 2020 05:58:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id b8sm4361808wrv.4.2020.08.21.05.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 05:58:11 -0700 (PDT)
Subject: Re: [PATCH v2] configure: add support for pseudo-"in source tree"
 builds
To: Kevin Wolf <kwolf@redhat.com>
References: <20200820173124.243984-1-berrange@redhat.com>
 <814594a0-391c-01fb-a418-234e477793d3@redhat.com>
 <20200821100426.GB5153@linux.fritz.box>
 <df28e5c2-ee4a-23d6-dcb2-04003a5d2757@redhat.com>
 <20200821105439.GE5153@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6414fb85-7267-2382-dc2d-f10f6c1cb115@redhat.com>
Date: Fri, 21 Aug 2020 14:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200821105439.GE5153@linux.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 12:54, Kevin Wolf wrote:
>>> Sounds like it will be painful to switch between branches based on make
>>> and branches based on meson. By extension, it will also be painful to
>>> check out and build old versions for comparison, or doing that even more
>>> than once during git bisect. :-(
>> Not if you switch to out-of-tree builds...
> I don't see what out-of-tree builds change about this unless I delete
> and reconfigure them after each step? Even in those cases where I use
> out-of-tree builds, I often reuse the same directory.

In two ways:

1) bisection will rarely jump around the point where Meson was
introduced.  First, because if it coincides with the 5.1.0 release, then
you know in advance if the problem was introduced before or after the
merge.  Second, because the bisection will quickly land on a merge
commit, and then you can (just for going down the merged branch) use a
separate out-of-tree build directory.

2) for the rare case of working on a branch that was developed pre-Meson
and has not been rebased (or need not be rebased), you again use a
separate out-of-tree build directory just for that one, and you don't
have to worry about doing distclean or an incremental builds.

Paolo


