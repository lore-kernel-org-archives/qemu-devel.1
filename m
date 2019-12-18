Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54B9C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FB82072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FB82072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUGG-0005wq-Lf
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ihUFR-0005OC-KH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ihUFQ-0005Zb-6L
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:59:57 -0500
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:33265)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ihUFP-0005Hl-Vj
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 02:59:56 -0500
Received: from player755.ha.ovh.net (unknown [10.108.16.187])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 80A2A239ACF
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 08:59:45 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id A6B91D81C0A3;
 Wed, 18 Dec 2019 07:59:43 +0000 (UTC)
Date: Wed, 18 Dec 2019 08:59:37 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 0/9] 9pfs: readdir optimization
Message-ID: <20191218085937.53a59594@bahia.lan>
In-Reply-To: <E1ihMuX-00076B-Qf@lizzy.crudebyte.com>
References: <E1ihMuX-00076B-Qf@lizzy.crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15884477363284908352
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddtkedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.165.232
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Christian,

It seems that there was an issue with the posting of these series. Threading
is inexistant. All the emails appear scattered and unsorted in my mailbox,
between 12/16 and 12/18... which is a bit painful. I'll try to find some time
to have a look anyway, but this greatly lowers the odds for these series to get
multiple reviews, which seems problematic given the ** NOTE: ** section you've
added to the cover. Please fix this.

Cheers,

--
Greg

On Wed, 18 Dec 2019 00:11:10 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> As previously mentioned, I was investigating performance issues with 9pfs.
> Raw file read/write of 9pfs is actually quite good, provided that client
> picked a reasonable high msize (maximum message size). I would recommend
> to log a warning on 9p server side if a client attached with a small msize
> that would cause performance issues for that reason.
> 
> However there other aspects where 9pfs currently performs suboptimally,
> especially readdir handling of 9pfs is extremely slow, a simple readdir
> request of a guest typically blocks for several hundred milliseconds or
> even several seconds, no matter how powerful the underlying hardware is.
> The reason for this performance issue: latency.
> Currently 9pfs is heavily dispatching a T_readdir request numerous times
> between main I/O thread and a background I/O thread back and forth; in fact
> it is actually hopping between threads even multiple times for every single
> directory entry during T_readdir request handling which leads in total to
> huge latencies for a single T_readdir request.
> 
> This patch series aims to address this severe performance issue of 9pfs
> T_readdir request handling. The actual performance fix is patch 8. I also
> provided a convenient benchmark for comparing the performance improvements
> by using the 9pfs "synth" driver (see patch 6 for instructions how to run
> the benchmark), so no guest OS installation is required to peform this
> benchmark A/B comparison. With patch 8 I achieved a performance improvement
> of factor 40 on my test machine.
> 
> ** NOTE: ** These patches are not heavily tested yet, nor thouroughly
> reviewed for potential security issues yet. I decided to post them already
> though, because I won't have the time in the next few weeks for polishing
> them. The benchmark results should demonstrate though that it is worth the
> hassle. So any testing/reviews/fixes appreciated!
> 
> Christian Schoenebeck (9):
>   tests/virtio-9p: v9fs_string_read() didn't terminate string
>   9pfs: validate count sent by client with T_readdir
>   hw/9pfs/9p-synth: added directory for readdir test
>   tests/virtio-9p: added READDIR test
>   tests/virtio-9p: check file names of READDIR response
>   9pfs: READDIR benchmark
>   hw/9pfs/9p-synth: avoid n-square issue in synth_readdir()
>   9pfs: T_readdir latency optimization
>   hw/9pfs/9p.c: benchmark time on T_readdir request
> 
>  hw/9pfs/9p-synth.c     |  46 ++++++++++-
>  hw/9pfs/9p-synth.h     |   5 ++
>  hw/9pfs/9p.c           | 150 ++++++++++++++++++---------------
>  hw/9pfs/9p.h           |  23 ++++++
>  hw/9pfs/codir.c        | 183 ++++++++++++++++++++++++++++++++++++++---
>  hw/9pfs/coth.h         |   3 +
>  tests/virtio-9p-test.c | 182 +++++++++++++++++++++++++++++++++++++++-
>  7 files changed, 509 insertions(+), 83 deletions(-)
> 


