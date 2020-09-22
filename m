Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B8DC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED913221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7lQSn9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED913221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrL5-0005or-T7
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 19:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKrCq-0002GX-Es
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kKrCo-0001tP-5n
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600815372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EpLwfAs7T6M1kuaa9lynFjNEFq3m3HyvU99buG9bmF0=;
 b=f7lQSn9O2Bo9qz5OlfUM2FuPl6r9gqLgnuQmZGD9TryGmSnRx17Rf+XbYiCJOpuAL4UvB2
 mJhMnCelV79y4ijgKFubX7RVi6g+CHZ8QvR1VU7fnM3owbOkGFA2JbEx3DMHQ/PLfThvaj
 g5NylwANIkBW/baw3fy8lyM3vswXQ8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-6H6xGArGOaGMnmlUzFfsmg-1; Tue, 22 Sep 2020 18:56:10 -0400
X-MC-Unique: 6H6xGArGOaGMnmlUzFfsmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDE68425CE;
 Tue, 22 Sep 2020 22:56:09 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-78.rdu2.redhat.com [10.10.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEC6F10021AA;
 Tue, 22 Sep 2020 22:56:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id D4D46223B13; Tue, 22 Sep 2020 18:56:02 -0400 (EDT)
Date: Tue, 22 Sep 2020 18:56:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: tools/virtiofs: Multi threading seems to hurt performance
Message-ID: <20200922225602.GJ57620@redhat.com>
References: <20200918213436.GA3520@redhat.com>
 <20200921201641.GD13362@redhat.com> <20200922110946.GB2836@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200922110946.GB2836@work-vm>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 12:09:46PM +0100, Dr. David Alan Gilbert wrote:
> 
> Do you have the numbers for:
>    epool
>    epool thread-pool-size=1
>    spool

Hi David,

Ok, I re-ran my numbers again after upgrading to latest qemu and also
upgraded host kernel to latest upstream. Apart from comparing I epool,
spool and 1Thread, I also ran their numa variants. That is I launched
qemu and virtiofsd on node 0 of machine (numactl --cpunodebind=0).

Results are kind of mixed. Here are my takeaways.

- Running on same numa node improves performance overall for exclusive,
  shared and exclusive-1T mode.

- In general both shared pool and exclusive-1T mode seem to perform
  better than exclusive mode, except for the case of randwrite-libaio.
  In some cases (seqread-libaio, seqwrite-libaio, seqwrite-libaio-multi)
  exclusive pool performs better than exclusive-1T.

- Looks like in some cases exclusive-1T performs better than shared
  pool. (randwrite-libaio, randwrite-psync-multi, seqwrite-psync-multi,
  seqwrite-psync, seqread-libaio-multi, seqread-psync-multi)


Overall, I feel that both exlusive-1T and shared perform better than
exclusive pool. Results between exclusive-1T and shared pool are mixed.
It seems like in many cases exclusve-1T performs better. I would say
that moving to "shared" pool seems like a reasonable option.

Thanks
Vivek

NAME                    WORKLOAD                Bandwidth       IOPS            
vtfs-none-epool         seqread-psync           38(MiB/s)       9967            
vtfs-none-epool-1T      seqread-psync           66(MiB/s)       16k             
vtfs-none-spool         seqread-psync           67(MiB/s)       16k             
vtfs-none-epool-numa    seqread-psync           48(MiB/s)       12k             
vtfs-none-epool-1T-numa seqread-psync           74(MiB/s)       18k             
vtfs-none-spool-numa    seqread-psync           74(MiB/s)       18k             

vtfs-none-epool         seqread-psync-multi     204(MiB/s)      51k             
vtfs-none-epool-1T      seqread-psync-multi     325(MiB/s)      81k             
vtfs-none-spool         seqread-psync-multi     271(MiB/s)      67k             
vtfs-none-epool-numa    seqread-psync-multi     253(MiB/s)      63k             
vtfs-none-epool-1T-numa seqread-psync-multi     349(MiB/s)      87k             
vtfs-none-spool-numa    seqread-psync-multi     301(MiB/s)      75k             

vtfs-none-epool         seqread-libaio          301(MiB/s)      75k             
vtfs-none-epool-1T      seqread-libaio          273(MiB/s)      68k             
vtfs-none-spool         seqread-libaio          334(MiB/s)      83k             
vtfs-none-epool-numa    seqread-libaio          315(MiB/s)      78k             
vtfs-none-epool-1T-numa seqread-libaio          326(MiB/s)      81k             
vtfs-none-spool-numa    seqread-libaio          335(MiB/s)      83k             

vtfs-none-epool         seqread-libaio-multi    202(MiB/s)      50k             
vtfs-none-epool-1T      seqread-libaio-multi    308(MiB/s)      77k             
vtfs-none-spool         seqread-libaio-multi    247(MiB/s)      61k             
vtfs-none-epool-numa    seqread-libaio-multi    238(MiB/s)      59k             
vtfs-none-epool-1T-numa seqread-libaio-multi    307(MiB/s)      76k             
vtfs-none-spool-numa    seqread-libaio-multi    269(MiB/s)      67k             

vtfs-none-epool         randread-psync          41(MiB/s)       10k             
vtfs-none-epool-1T      randread-psync          67(MiB/s)       16k             
vtfs-none-spool         randread-psync          64(MiB/s)       16k             
vtfs-none-epool-numa    randread-psync          48(MiB/s)       12k             
vtfs-none-epool-1T-numa randread-psync          73(MiB/s)       18k             
vtfs-none-spool-numa    randread-psync          72(MiB/s)       18k             

vtfs-none-epool         randread-psync-multi    207(MiB/s)      51k             
vtfs-none-epool-1T      randread-psync-multi    313(MiB/s)      78k             
vtfs-none-spool         randread-psync-multi    265(MiB/s)      66k             
vtfs-none-epool-numa    randread-psync-multi    253(MiB/s)      63k             
vtfs-none-epool-1T-numa randread-psync-multi    340(MiB/s)      85k             
vtfs-none-spool-numa    randread-psync-multi    305(MiB/s)      76k             

vtfs-none-epool         randread-libaio         305(MiB/s)      76k             
vtfs-none-epool-1T      randread-libaio         308(MiB/s)      77k             
vtfs-none-spool         randread-libaio         329(MiB/s)      82k             
vtfs-none-epool-numa    randread-libaio         310(MiB/s)      77k             
vtfs-none-epool-1T-numa randread-libaio         328(MiB/s)      82k             
vtfs-none-spool-numa    randread-libaio         339(MiB/s)      84k             

vtfs-none-epool         randread-libaio-multi   265(MiB/s)      66k             
vtfs-none-epool-1T      randread-libaio-multi   267(MiB/s)      66k             
vtfs-none-spool         randread-libaio-multi   269(MiB/s)      67k             
vtfs-none-epool-numa    randread-libaio-multi   314(MiB/s)      78k             
vtfs-none-epool-1T-numa randread-libaio-multi   319(MiB/s)      79k             
vtfs-none-spool-numa    randread-libaio-multi   318(MiB/s)      79k             

vtfs-none-epool         seqwrite-psync          36(MiB/s)       9224            
vtfs-none-epool-1T      seqwrite-psync          67(MiB/s)       16k             
vtfs-none-spool         seqwrite-psync          61(MiB/s)       15k             
vtfs-none-epool-numa    seqwrite-psync          44(MiB/s)       11k             
vtfs-none-epool-1T-numa seqwrite-psync          69(MiB/s)       17k             
vtfs-none-spool-numa    seqwrite-psync          68(MiB/s)       17k             

vtfs-none-epool         seqwrite-psync-multi    193(MiB/s)      48k             
vtfs-none-epool-1T      seqwrite-psync-multi    299(MiB/s)      74k             
vtfs-none-spool         seqwrite-psync-multi    240(MiB/s)      60k             
vtfs-none-epool-numa    seqwrite-psync-multi    233(MiB/s)      58k             
vtfs-none-epool-1T-numa seqwrite-psync-multi    358(MiB/s)      89k             
vtfs-none-spool-numa    seqwrite-psync-multi    285(MiB/s)      71k             

vtfs-none-epool         seqwrite-libaio         265(MiB/s)      66k             
vtfs-none-epool-1T      seqwrite-libaio         245(MiB/s)      61k             
vtfs-none-spool         seqwrite-libaio         312(MiB/s)      78k             
vtfs-none-epool-numa    seqwrite-libaio         295(MiB/s)      73k             
vtfs-none-epool-1T-numa seqwrite-libaio         282(MiB/s)      70k             
vtfs-none-spool-numa    seqwrite-libaio         297(MiB/s)      74k             

vtfs-none-epool         seqwrite-libaio-multi   313(MiB/s)      78k             
vtfs-none-epool-1T      seqwrite-libaio-multi   299(MiB/s)      74k             
vtfs-none-spool         seqwrite-libaio-multi   315(MiB/s)      78k             
vtfs-none-epool-numa    seqwrite-libaio-multi   318(MiB/s)      79k             
vtfs-none-epool-1T-numa seqwrite-libaio-multi   410(MiB/s)      102k            
vtfs-none-spool-numa    seqwrite-libaio-multi   378(MiB/s)      94k             

vtfs-none-epool         randwrite-psync         33(MiB/s)       8629            
vtfs-none-epool-1T      randwrite-psync         61(MiB/s)       15k             
vtfs-none-spool         randwrite-psync         63(MiB/s)       15k             
vtfs-none-epool-numa    randwrite-psync         49(MiB/s)       12k             
vtfs-none-epool-1T-numa randwrite-psync         68(MiB/s)       17k             
vtfs-none-spool-numa    randwrite-psync         66(MiB/s)       16k             

vtfs-none-epool         randwrite-psync-multi   186(MiB/s)      46k             
vtfs-none-epool-1T      randwrite-psync-multi   300(MiB/s)      75k             
vtfs-none-spool         randwrite-psync-multi   233(MiB/s)      58k             
vtfs-none-epool-numa    randwrite-psync-multi   235(MiB/s)      58k             
vtfs-none-epool-1T-numa randwrite-psync-multi   355(MiB/s)      88k             
vtfs-none-spool-numa    randwrite-psync-multi   266(MiB/s)      66k             

vtfs-none-epool         randwrite-libaio        289(MiB/s)      72k             
vtfs-none-epool-1T      randwrite-libaio        284(MiB/s)      71k             
vtfs-none-spool         randwrite-libaio        278(MiB/s)      69k             
vtfs-none-epool-numa    randwrite-libaio        292(MiB/s)      73k             
vtfs-none-epool-1T-numa randwrite-libaio        294(MiB/s)      73k             
vtfs-none-spool-numa    randwrite-libaio        290(MiB/s)      72k             

vtfs-none-epool         randwrite-libaio-multi  317(MiB/s)      79k             
vtfs-none-epool-1T      randwrite-libaio-multi  323(MiB/s)      80k             
vtfs-none-spool         randwrite-libaio-multi  330(MiB/s)      82k             
vtfs-none-epool-numa    randwrite-libaio-multi  315(MiB/s)      78k             
vtfs-none-epool-1T-numa randwrite-libaio-multi  409(MiB/s)      102k            
vtfs-none-spool-numa    randwrite-libaio-multi  384(MiB/s)      96k             


