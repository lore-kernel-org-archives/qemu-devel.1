Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7F7CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 08:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1155B21929
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 08:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="SdZutIF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1155B21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRY1n-0003kq-66
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 03:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ross.lagerwall@citrix.com>) id 1iRY0U-0003Eg-Tn
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 03:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ross.lagerwall@citrix.com>) id 1iRY0T-0007XG-Hn
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 03:46:38 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:13828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ross.lagerwall@citrix.com>)
 id 1iRY0T-0007WA-5g; Mon, 04 Nov 2019 03:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1572857197;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=AvKd/MffpkKNF8Vzh9Hy7rIYjEF4bX1NIsxrFs+n7hU=;
 b=SdZutIF5LoCvngB7YbDT5JnAz0thxZE3h6bVy38QC23A2FTwwHKpRi0Z
 9oo8P7glUw6HRLgLZQPjpVQDRhIAlEtJhhd2sxsYM0jbJUK1uBOda2hDX
 NmquOOrTlAPO7wtzIij5lc6pjopgsLZ2qO5E+2Qrc3yfd96iDdxlKrnA9 w=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=ross.lagerwall@citrix.com;
 spf=Pass smtp.mailfrom=ross.lagerwall@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 ross.lagerwall@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="ross.lagerwall@citrix.com";
 x-sender="ross.lagerwall@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 ross.lagerwall@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="ross.lagerwall@citrix.com";
 x-sender="ross.lagerwall@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="ross.lagerwall@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: pjEBCojp1ZysB9ftkfqcAvkBioc8tsW2O03ezr/GLcYej/1nedPyEReqLo0sRQiI8CjnkPo9hv
 wFLPTH0ew/dWF3AkLKSv7UbAVqcEdS8lwK0Zk4Jg0lUofT9mTomZT3zrC/i/xdlhFYcUn5Lbag
 FrV/5wwrqkPpwQjFFeXEES1+nqs4RGB6b22JbgFw8FbuU7virtb/pbMnnqsOWlzQ44j7MOyadt
 E4ODD91VhHEFBkLzCeNsC8qI9tSsQNP7SJCFxi8AX2AkgOegKxSAD0DD4RpNDJ4Wyv48hIQ/GD
 E9I=
X-SBRS: 2.7
X-MesageID: 7896695
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.68,266,1569297600"; 
   d="scan'208";a="7896695"
Subject: Re: [Qemu-devel] [PATCH 16/16] nvme: support multiple namespaces
To: Klaus Birkelund <klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
 <20190705072333.17171-17-klaus@birkelund.eu>
 <79fb195f-91dc-869d-f290-40fdcb96eea3@citrix.com>
 <20190823081022.GA30440@apples.localdomain>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <675ecf34-4874-7a10-998a-f85c4aeb9526@citrix.com>
Date: Mon, 4 Nov 2019 08:46:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823081022.GA30440@apples.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.142
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, matt.fitzpatrick@oakgatetech.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, keith.busch@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 9:10 AM, Klaus Birkelund wrote:
> On Thu, Aug 22, 2019 at 02:18:05PM +0100, Ross Lagerwall wrote:
>> On 7/5/19 8:23 AM, Klaus Birkelund Jensen wrote:
>>
>> I tried this patch series by installing Windows with a single NVME
>> controller having two namespaces. QEMU crashed in get_feature /
>> NVME_VOLATILE_WRITE_CACHE because req->ns was NULL.
>>
> 
> Hi Ross,
> 
> Good catch!
> 
>> nvme_get_feature / nvme_set_feature look wrong to me since I can't see how
>> req->ns would have been set. Should they have similar code to nvme_io_cmd to
>> set req->ns from cmd->nsid?
> 
> Definitely. I will fix that for v2.
> 
>>
>> After working around this issue everything else seemed to be working well.
>> Thanks for your work on this patch series.
>>
> 
> And thank you for trying out my patches!
> 

One more thing... it doesn't handle inactive namespaces properly so if you
have two namespaces with e.g. nsid=1 and nsid=3 QEMU ends up crashing in
certain situations. The patch below adds support for inactive namespaces.

Still hoping to see a v2 some day :-)

Thanks,
Ross

---------------------- 8-< ----------------------
nvme-ns: Allow inactive namespaces

The controller advertises the maximum namespace number but not all of these
slots may have proper namespaces. These are defined as inactive namespaces by
the spec.  Implement support for inactive namespaces instead of crashing.

Changes are needed in a few places:
* When identify_ns is used with an inactive namespace, the controller should
  return all zeroes.
* Only active namespaces should be returned by identify_ns_list.
* When the controller is unplugged, only cleanup active namespaces.
* Keep track of and advertise the maximum valid namespace number rather than
* the number of active namespaces.
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1b8a09853d..29ea5c2023 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1302,6 +1302,7 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     NvmeNamespace *ns;
+    NvmeIdNs *id_ns, invalid_ns_id = {0};
     uint32_t nsid = le32_to_cpu(cmd->nsid);
 
     trace_nvme_identify_ns(nsid);
@@ -1312,9 +1313,13 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     }
 
     ns = n->namespaces[nsid - 1];
+    if (ns) {
+        id_ns = &ns->id_ns;
+    } else {
+        id_ns = &invalid_ns_id;
+    }
 
-    return nvme_dma_read(n, (uint8_t *) &ns->id_ns, sizeof(ns->id_ns), cmd,
-        req);
+    return nvme_dma_read(n, (uint8_t *) id_ns, sizeof(*id_ns), cmd, req);
 }
 
 static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
@@ -1330,7 +1335,7 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
 
     list = g_malloc0(data_len);
     for (i = 0; i < n->num_namespaces; i++) {
-        if (i < min_nsid) {
+        if (i < min_nsid || !n->namespaces[i]) {
             continue;
         }
         list[j++] = cpu_to_le32(i + 1);
@@ -1861,7 +1866,9 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
     int i;
 
     for (i = 0; i < n->num_namespaces; i++) {
-        blk_drain(n->namespaces[i]->conf.blk);
+        if (n->namespaces[i]) {
+            blk_drain(n->namespaces[i]->conf.blk);
+        }
     }
 
     for (i = 0; i < n->params.num_queues; i++) {
@@ -1886,7 +1893,9 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
     }
 
     for (i = 0; i < n->num_namespaces; i++) {
-        blk_flush(n->namespaces[i]->conf.blk);
+        if (n->namespaces[i]) {
+            blk_flush(n->namespaces[i]->conf.blk);
+        }
     }
 
     n->bar.cc = 0;
@@ -2464,8 +2473,9 @@ int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     trace_nvme_register_namespace(nsid);
 
     n->namespaces[nsid - 1] = ns;
-    n->num_namespaces++;
-    n->id_ctrl.nn++;
+    if (nsid > n->num_namespaces)
+        n->num_namespaces = nsid;
+    n->id_ctrl.nn = n->num_namespaces;
 
     return 0;
 }

