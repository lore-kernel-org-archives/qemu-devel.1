Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62767C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76A0206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="W19TY/b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76A0206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3lD-0004l0-KO
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmantipov@yandex.ru>)
 id 1kc3hM-000226-GC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:42:53 -0500
Received: from forward102j.mail.yandex.net ([5.45.198.243]:41508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmantipov@yandex.ru>)
 id 1kc3hH-0001pd-4W
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:42:52 -0500
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
 by forward102j.mail.yandex.net (Yandex) with ESMTP id 9BC7DF208C9
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 12:42:40 +0300 (MSK)
Received: from mxback1q.mail.yandex.net (mxback1q.mail.yandex.net
 [IPv6:2a02:6b8:c0e:39:0:640:25b3:aea5])
 by forward100q.mail.yandex.net (Yandex) with ESMTP id 98EF1708000E
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 12:42:40 +0300 (MSK)
Received: from vla5-47b3f4751bc4.qloud-c.yandex.net
 (vla5-47b3f4751bc4.qloud-c.yandex.net [2a02:6b8:c18:3508:0:640:47b3:f475])
 by mxback1q.mail.yandex.net (mxback/Yandex) with ESMTP id HAUGXttBaM-gelqrwli; 
 Mon, 09 Nov 2020 12:42:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1604914960; bh=bUjpdZPctYqAhWGGybDxjG+eXu8Kg6dBwrra58W6n1A=;
 h=Subject:From:To:Date:Message-ID;
 b=W19TY/b55bBD+6ajrcJtUUMpa4Rmjrc06xtEiqmrcRwhu6LqW907bPDPjz7WzbnS3
 t5Kgf4SmmuTg/gtwsi8E4zGZUMleP9qIVV11qbJ5QgvSp7ztZ8JaotPEqOGfoFX+Th
 WqucLowlv4g6lagYl8PlDpPeX6tfdrgb5nFr2HJw=
Authentication-Results: mxback1q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-47b3f4751bc4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id j3lXlYiSeg-gdoWga2P; Mon, 09 Nov 2020 12:42:39 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
To: qemu-devel@nongnu.org
From: Dmitry Antipov <dmantipov@yandex.ru>
Subject: On virtio and glusterfs block device
Message-ID: <cc05ca73-00ba-7ed7-2b27-b540905d19e5@yandex.ru>
Date: Mon, 9 Nov 2020 12:42:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.45.198.243; envelope-from=dmantipov@yandex.ru;
 helo=forward102j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 04:42:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I'm running x86 Ubuntu VM with GlusterFS-backed /, e.g.

qemu-system-x86_64 -enable-kvm -smp 8 -m 4096 -drive \
file=gluster://192.168.1.xxx/test/bionic.qcow2,if=virtio

and the following Fio (https://github.com/axboe/fio) benchmark inside a VM:

[global]
name=fio-rand-write-libaio
filename=fio-rand-write
ioengine=libaio
create_on_open=1
rw=randwrite
direct=0
numjobs=8
time_based=1
runtime=60

[test-4-kbytes]
bs=4k
size=1G
iodepth=8

(e.g. 8 tasks issues 4K-sized random writes across 1G file inside a VM).

Tracing I/O path down to qemu_gluster_co_rw() (block/gluster.c), I've found that
glfs_pwritev_async() is asked to write I/O vectors of the very different length
(mostly 1, average may be 15-20, and maximum value is around 150). Since the
workload generated by Fio looks regular and stable over the running time, this
looks suboptimal. At the first glance, long batches of I/O vectors of the same
length should give the better performance.

Next, looking through virtio_blk_submit_multireq() shows that non-sequential
requests are not merged. IIUC this approach assumes that the virtual block device
is always backed by the physical one - but what if not? In GlusterFS API, each
glfs_xxx() call requires the roundtrip to the server at least, and merging more
(even non-sequential) requests into longer I/O vectors may be really useful.

So, 1) is my understanding of the whole picture is correct and 2) is there
something to tune in attempt to improve an I/O performance in my case?

Thanks,
Dmitry

