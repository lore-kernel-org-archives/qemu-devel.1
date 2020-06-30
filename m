Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66142C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EFB2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUTv0uR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EFB2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGyH-0005jl-Dd
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqGxY-0005BO-VM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:10:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqGxW-0003p0-H6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593526201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t0gtZ6qRY49je4oS7Q0rYZgYQjfmuwia/Sn+7qV8N2Q=;
 b=IUTv0uR/7Rj2JGPaw8wMv+eSJ00YR+TPb0tW1tRKWH9s3lGofbRVaK2kvAJYms75zzvr39
 kNvaa8rSE1n5MW3j4Fe59c92vY1bKw20tLeJeZvG6irOG3j0E5Yl8YaiAz3tXLzX7+J6L2
 YbtoVjUY48dy1Bg5ARkbCn7ZjSIjvzM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-xjtwhmbFM-SmGC9tHsi3iA-1; Tue, 30 Jun 2020 10:09:50 -0400
X-MC-Unique: xjtwhmbFM-SmGC9tHsi3iA-1
Received: by mail-ej1-f70.google.com with SMTP id b24so13131885ejb.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 07:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=t0gtZ6qRY49je4oS7Q0rYZgYQjfmuwia/Sn+7qV8N2Q=;
 b=FM0Mad863Eyadea2HGG6VZSglx1KHPYCLg76jhtdk6tPd0RmOY5qDIt9+Tqc++3nRl
 htTghj049zx39SwkXB9k65xIJM/lbeaveV0GD3aKhYuuTeJs9WR50VSaBcy8TE9PfIfX
 Y72l+5egmAand77okvkzax3V3w+ac8mvvqpn6FiVhhtFcKhyekRiIP+ILc1nYZW2SbDQ
 3Nh58nLrUPKfOos/80I/2/KMBed7Qm7yNv6E932/IRlX4CuWz0uhi6lEPY5A81YbdQ2w
 0w2Bfa00YKOvBCVdXRWuXV+4CO6Y6VPJftoq4+niwQ1BP9oUleKtkVhUHQUrEfbTHTao
 eLBg==
X-Gm-Message-State: AOAM533KzveV8Psg45zT79MqCOYfEYBFlkEWHY5q6jP2HqxU9Tr2Burk
 Jn19Shx9W9/oZQ/l3CzwOlJHKZGNSQghMwFD7L5vE1dhHMKxAtssJVbBXY+kjKQPVYAKDQ6+GbE
 xYOpVzO34cfqdNfc=
X-Received: by 2002:a17:906:fb99:: with SMTP id
 lr25mr18370083ejb.49.1593526189067; 
 Tue, 30 Jun 2020 07:09:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysNP5ioiWqmb/vjgGx3oaK57b4x93vcbTlrp9Ktou4116H+08V6/i6EhQgP99SXLO/f6F/pg==
X-Received: by 2002:a17:906:fb99:: with SMTP id
 lr25mr18370052ejb.49.1593526188747; 
 Tue, 30 Jun 2020 07:09:48 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id rv16sm2166148ejb.60.2020.06.30.07.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 07:09:48 -0700 (PDT)
Subject: Re: [PATCH 00/10] hw/block/nvme: namespace types and zoned namespaces
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <its@irrelevant.dk>
References: <20200630100139.1483002-1-its@irrelevant.dk>
 <20200630125932.GA553472@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <c10b18a8-44f3-7dab-b9bb-7d017f210934@redhat.com>
Date: Tue, 30 Jun 2020 16:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630125932.GA553472@localhost.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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
Cc: Kevin Wolf <kwolf@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 2:59 PM, Niklas Cassel wrote:
> On Tue, Jun 30, 2020 at 12:01:29PM +0200, Klaus Jensen wrote:
>> From: Klaus Jensen <k.jensen@samsung.com>
>>
>> Hi all,
> 
> Hello Klaus,
> 
>>
>> This series adds support for TP 4056 ("Namespace Types") and TP 4053
>> ("Zoned Namespaces") and is an alternative implementation to the one
>> submitted by Dmitry[1].
>>
>> While I don't want this to end up as a discussion about the merits of
>> each version, I want to point out a couple of differences from Dmitry's
>> version. At a glance, my version
>>
>>   * builds on my patch series that adds fairly complete NVMe v1.4
>>     mandatory support, as well as nice-to-have feature such as SGLs,
>>     multiple namespaces and mostly just overall clean up. This finally
>>     brings the nvme device into a fairly compliant state on which we can
>>     add new features. I've tried hard to get these compliance and
>>     clean-up patches merged for a long time (in parallel with developing
>>     the emulation of NST and ZNS) and I would be really sad to see them
>>     by-passed since they have already been through many iterations and
>>     already carries Acked- and Reviewed-by's for the bulk of the
>>     patches. I think the nvme device is already in a "frankenstate" wrt.
>>     the implemented nvme version and the features it currently supports,
>>     so I think this kind of cleanup is long overdue.
>>
>>   * uses an attached blockdev and standard blk_aio for persistent zone
>>     info. This is the same method used in our patches for Write
>>     Uncorrectable and (separate and extended lba) metadata support, but
>>     I've left those optional features out for now to ease the review
>>     process.
>>
>>   * relies on the universal dulbe support added in ("hw/block/nvme: add
>>     support for dulbe") and sparse images for handling reads in gaps
>>     (above write pointer and below ZSZE); that is - the size of the
>>     underlying blockdev is in terms of ZSZE, not ZCAP
>>
>>   * the controller uses timers to autonomously finish zones (wrt. FRL)
> 
> AFAICT, Dmitry's patches does this as well.
> 
>>
>> I've been on paternity leave for a month, so I havn't been around to
>> review Dmitry's patches, but I have started that process now. I would
>> also be happy to work with Dmitry & Friends on merging our versions to
>> get the best of both worlds if it makes sense.
>>
>> This series and all preparatory patch sets (the ones I've been posting
>> yesterday and today) are available on my GitHub[2]. Unfortunately
>> Patchew got screwed up in the middle of me sending patches and it never
>> picked up v2 of "hw/block/nvme: support multiple namespaces" because it
>> was getting late and I made a mistake with the CC's. So my posted series
>> don't apply according to Patchew, but they actually do if you follow the
>> Based-on's (... or just grab [2]).
>>
>>
>>   [1]: Message-Id: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
>>   [2]: https://github.com/birkelund/qemu/tree/for-master/nvme
>>
>>
>> Based-on: <20200630043122.1307043-1-its@irrelevant.dk>
>> ("[PATCH 0/3] hw/block/nvme: bump to v1.4")
> 
> Is this the only patch series that this series depends on?
> 
> In the beginning of the cover letter, you mentioned
> "NVMe v1.4 mandatory support", "SGLs", "multiple namespaces",
> and "and mostly just overall clean up".
> 
>>
>> Klaus Jensen (10):
>>   hw/block/nvme: support I/O Command Sets
>>   hw/block/nvme: add zns specific fields and types
>>   hw/block/nvme: add basic read/write for zoned namespaces
>>   hw/block/nvme: add the zone management receive command
>>   hw/block/nvme: add the zone management send command
>>   hw/block/nvme: add the zone append command
>>   hw/block/nvme: track and enforce zone resources
>>   hw/block/nvme: allow open to close transitions by controller
>>   hw/block/nvme: allow zone excursions
>>   hw/block/nvme: support reset/finish recommended limits
>>
>>  block/nvme.c          |    6 +-
>>  hw/block/nvme-ns.c    |  397 +++++++++-
>>  hw/block/nvme-ns.h    |  148 +++-
>>  hw/block/nvme.c       | 1676 +++++++++++++++++++++++++++++++++++++++--
>>  hw/block/nvme.h       |   76 +-
>>  hw/block/trace-events |   43 +-
>>  include/block/nvme.h  |  252 ++++++-
>>  7 files changed, 2469 insertions(+), 129 deletions(-)
>>
>> -- 
>> 2.27.0
>>
> 
> I think that you have done a great job getting the NVMe
> driver out of a frankenstate, and made it compliant with
> a proper spec (NVMe 1.4).
> 
> I'm also a big fan of the refactoring so that the driver
> handles more than one namespace, and the new bus model.
> 
> I know that you first sent your
> "nvme: support NVMe v1.3d, SGLs and multiple namespaces"
> patch series July, last year.
> 
> Looking at your outstanding patch series on patchwork:
> https://patchwork.kernel.org/project/qemu-devel/list/?submitter=188679
> 
> (Feel free to correct me if I have misunderstood anything.)
> 
> I see that these are related to your patch series from July last year:
> hw/block/nvme: bump to v1.3
> hw/block/nvme: support scatter gather lists
> hw/block/nvme: support multiple namespaces
> hw/block/nvme: bump to v1.4
> 
> 
> This patch series seems minor and could probably be merged immediately:
> hw/block/nvme: handle transient dma errors
> 
> 
> This patch series looks a bit weird:
> hw/block/nvme: AIO and address mapping refactoring
> 
> Since it looks like a V1 post, and was first posted yesterday.
> However, 2 out of the 17 patches in are Acked-by: Keith.
> (Perhaps some of your previously posted patches was put inside
> this new patch series?)
> 
> 
> This patch series:
> hw/block/nvme: namespace types and zoned namespaces
> 
> Which was first posted today. Up until earlier today, we haven't seen
> any patches from you related to ZNS (only overall NVMe cleanups).
> Dmitry's ZNS patches have been on the list since 2020-06-16.
> 
> 
> Just a friendly suggestion, how about:
> 
> 1) We get your
> 
> hw/block/nvme: bump to v1.3
> hw/block/nvme: support scatter gather lists
> hw/block/nvme: support multiple namespaces
> hw/block/nvme: bump to v1.4
> 
> patch series merged.
> 
> 2) We get Dmitry's patch series merged.
> 
> Shared 4:th) If there is any feature that you miss in Dmitry's patch series,
> perhaps you could send patches to add what you are missing.
> 
> Shared 4:th) Your other patch series:
> hw/block/nvme: AIO and address mapping refactoring could get merged.
> 
> 
> Please don't take this suggestion the wrong way, I'm simply trying
> to come up with a way to move forward from here.

Few months ago Klaus sent a bomb series with ~80 patches, we asked
him to split in digestible series of ~20 patches.

Earlier in this cover Klaus provided a link to his git repository
with all the patches sorted [2]:
https://github.com/birkelund/qemu/tree/for-master/nvme

This seems enough to get the big picture.

Niklas Cassel, it would be helpful if you or Dmitry can review
Klaus patches. I see Klaus is already reviewing Dmitry ones.

Both Keith and Kevin are quite busy recently.

To help them I suggest once you reviewed your patches each other,
one of you could send the big series with all patches together.

Anyway soft-freeze is next week, so you have to decide what is
critical.

What I see doable for the following days is:
- hw/block/nvme: Fix I/O BAR structure [3]
- hw/block/nvme: handle transient dma errors
- hw/block/nvme: bump to v1.3

[3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718086.html

> 
> 
> Kind regards,
> Niklas
> 


