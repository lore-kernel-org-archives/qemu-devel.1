Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47139C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2016F20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2016F20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaill-0005GY-9D
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jaijP-0000lR-HQ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:35:11 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:39554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jaijO-0004GJ-9A
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:35:11 -0400
Received: from player793.ha.ovh.net (unknown [10.108.57.150])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id A742C13D132
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 18:35:07 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 0F0571286195B;
 Mon, 18 May 2020 16:35:04 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0066f8dc0d0-015b-4097-bbfa-425a80ea9ebe,2C24A610C85E6C9E8BC980A9294C46B072FAA192)
 smtp.auth=groug@kaod.org
Date: Mon, 18 May 2020 18:35:04 +0200
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] 9p: Lock directory streams with a CoMutex
Message-ID: <20200518183504.679a99aa@bahia.lan>
In-Reply-To: <158981894794.109297.3530035833368944254.stgit@bahia.lan>
References: <158981894794.109297.3530035833368944254.stgit@bahia.lan>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13347261924409973056
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddthedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhephfduiefgveefiefffeekgfeuffdutddvieefkeethfehjeeikeejuedvgeegjeeinecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.40.148; envelope-from=groug@kaod.org;
 helo=5.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 12:35:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 18:22:28 +0200
Greg Kurz <groug@kaod.org> wrote:

> Locking was introduced in QEMU 2.7 to address the deprecation of
> readdir_r(3) in glibc 2.24. It turns out that the frontend code is
> the worst place to handle a critical section with a pthread mutex:
> the code runs in a coroutine on behalf of the QEMU mainloop and then
> yields control, waiting for the fsdev backend to process the request
> in a worker thread. If the client resends another readdir request for
> the same fid before the previous one finally unlocked the mutex, we're
> deadlocked.
> 
> This never bit us because the linux client serializes readdir requests
> for the same fid, but it is quite easy to demonstrate with a custom
> client.
> 
> A good solution could be to narrow the critical section in the worker
> thread code and to return a copy of the dirent to the frontend, but
> this causes quite some changes in both 9p.c and codir.c. So, instead
> of that, in order for people to easily backport the fix to older QEMU
> versions, let's simply use a CoMutex since all the users for this
> sit in coroutines.
> 
> Fixes: 7cde47d4a89d ("9p: add locking to V9fsDir")
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

Just to clarify, this is v2 of:

9pfs: Fix potential deadlock of QEMU mainloop

https://patchwork.ozlabs.org/project/qemu-devel/patch/158826201391.1344781.9403916162733181811.stgit@bahia.lan/

>  hw/9pfs/9p.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index dd1c6cb8d2f4..3ab580764cf8 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -197,22 +197,22 @@ typedef struct V9fsXattr
>  
>  typedef struct V9fsDir {
>      DIR *stream;
> -    QemuMutex readdir_mutex;
> +    CoMutex readdir_mutex;
>  } V9fsDir;
>  
>  static inline void v9fs_readdir_lock(V9fsDir *dir)
>  {
> -    qemu_mutex_lock(&dir->readdir_mutex);
> +    qemu_co_mutex_lock(&dir->readdir_mutex);
>  }
>  
>  static inline void v9fs_readdir_unlock(V9fsDir *dir)
>  {
> -    qemu_mutex_unlock(&dir->readdir_mutex);
> +    qemu_co_mutex_unlock(&dir->readdir_mutex);
>  }
>  
>  static inline void v9fs_readdir_init(V9fsDir *dir)
>  {
> -    qemu_mutex_init(&dir->readdir_mutex);
> +    qemu_co_mutex_init(&dir->readdir_mutex);
>  }
>  
>  /*
> 
> 


