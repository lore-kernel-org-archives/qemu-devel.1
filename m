Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A411C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570F2207DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMSZsCw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570F2207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBKrP-0004c3-Lz
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 12:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kBKqt-0004AV-SI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kBKqr-0001Sn-H0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598546051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RsdwAWJfvsSxgVTZ/bAQxN2DVsI87CFtNwhh5DS06k0=;
 b=FMSZsCw9zZYzublY6Yg7fG1pb0TcHc+ADSJ7gtj01T3dJALvNXUviSbKrrjP5TLaHFmEAx
 cJOe6oPYDnBoVujfPxnYysb58X1a27PA2iOKJWOmDb1xW2SogjkL8sBCapo9xECFwaS/Tl
 RUQyqxW91hKnoBpP9Fi3aoXShQ3217s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-uknCXD8xO426LX0E9bccjQ-1; Thu, 27 Aug 2020 12:34:09 -0400
X-MC-Unique: uknCXD8xO426LX0E9bccjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D5F410ABDCC
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 16:34:08 +0000 (UTC)
Received: from [10.36.112.112] (ovpn-112-112.ams2.redhat.com [10.36.112.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15CCE5B6B7;
 Thu, 27 Aug 2020 16:34:04 +0000 (UTC)
Subject: Re: [PATCH] test-vmstate: fix bad GTree usage, use-after-free
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20200827161826.1165971-1-marcandre.lureau@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c52960c3-d88c-010d-584a-75917bc9b702@redhat.com>
Date: Thu, 27 Aug 2020 18:34:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200827161826.1165971-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc-Andre

On 8/27/20 6:18 PM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> According to g_tree_foreach() documentation:
> "The tree may not be modified while iterating over it (you can't
> add/remove items)."

Hum I did not see that.
> 
> Fixes: 9a85e4b8f6 ("migration: Support gtree migration")
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-vmstate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index f7b3868881..31aefa78f0 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -1078,7 +1078,6 @@ static gboolean diff_tree(gpointer key, gpointer value, gpointer data)
>      struct match_node_data d = {tp->tree2, key, value};
>  
>      g_tree_foreach(tp->tree2, tp->match_node, &d);
> -    g_tree_remove(tp->tree1, key);
it does not test the same thing I am afraid. If one of the trees
contains more elements than the others this won't be detected.

Also there is another case of removal inside the traversal in the
match_node(): in match_interval_mapping_node() and match_domain_node()

Thanks

Eric


>      return false;
>  }
>  
> @@ -1088,7 +1087,7 @@ static void compare_trees(GTree *tree1, GTree *tree2,
>      struct tree_cmp_data tp = {tree1, tree2, function};
>  
>      g_tree_foreach(tree1, diff_tree, &tp);
> -    assert(g_tree_nnodes(tree1) == 0);> +    g_tree_destroy(g_tree_ref(tree1));
>      assert(g_tree_nnodes(tree2) == 0);
>  }
>  
> 


