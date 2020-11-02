Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A579C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187762222B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="BjPycm7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187762222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeVC-0006s8-UY
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kZeR6-0001dI-GK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:20:08 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kZeQy-0006ix-9Z
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:20:08 -0500
Received: by mail-lj1-x242.google.com with SMTP id y16so16117928ljk.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G3YrJVgX998qKuhMvPXP2IEY2yBy5bIH1EzHgRLGBYE=;
 b=BjPycm7D1uUxofL/ILn6p9n2tItlEAGmYonYawVDoe48j9DkDcEwxhPvTOkvsgXBSP
 1Nb68AJCiNObWQuDa5DO8MWJoyAZcu6bjKtshY6QooRg5CNFtoB0dyiXlEwjmv8jlWyE
 vYLnCXdzjB7OUS4T+sAvQBS+uQPMuTxBbAGL4tLrscMFRdJA8hzBnmwu/yrXG45zT3ip
 tnQacb7GNhCKhJk13gtDEpvAtT2i+S9/5GrzJU9Bd1tVsLRcmLJC1JN+75GsXWf9p8TM
 yqNIzmHMBKuDVqO1g+vq78s7/NiyZhtm6BdiQFjmeE8/E3LggzEOolwP0sUFdoDHN0F2
 Qn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G3YrJVgX998qKuhMvPXP2IEY2yBy5bIH1EzHgRLGBYE=;
 b=V5aZlfbY47EYssMIDVieqaBvCB65cCk15QrqJpd3xbMCEU1EQB+TfAVPeRdArY+u2P
 Z/mArKUeVVPkzeRFXjm3Jpw3c6UsAOrztIhxqdJABmh33BjwktNNVETra0dI69PvqLzp
 zl1VykL+EvexYr45cUmrKgXHjMRVstNZVnqZ2AxyAXcWuUEPbtjAJCPjdhgGxHKK79kb
 1WyTypOIJXdRALnyamFLFUSbSrhnt7x7FW/kbCfBuZWUIMq7I/PMEiv3jvNHX77vxAf3
 1UpWEpsjFkzdhFT3JDCSjsz9q1PnXh1ddsQoy4MB2mCyXe2L00R7+ZUSSajHt2M/PdcH
 tL+g==
X-Gm-Message-State: AOAM533QTuXuHsGaFHfuc+sFc479V4nw3iiYxBo72M0DA75bpwxvuofd
 mFD9nzdeRZXJzRL4CXgf/VV14Q==
X-Google-Smtp-Source: ABdhPJxDljeBM6U+uC5luHm6WgUGUIDcqLOO7W2UTKJ3BylzInvH0piwBMoBjQeQ/SXxDj2AIf2p/g==
X-Received: by 2002:a2e:7007:: with SMTP id l7mr7533678ljc.185.1604341198473; 
 Mon, 02 Nov 2020 10:19:58 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id c6sm2527007lfm.226.2020.11.02.10.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 10:19:57 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [RFC PATCH 6/6] docs: Added eBPF documentation.
Date: Mon,  2 Nov 2020 20:51:16 +0200
Message-Id: <20201102185115.7425-7-andrew@daynix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102185115.7425-1-andrew@daynix.com>
References: <20201102185115.7425-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::242;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: yan@daynix.com, yuri.benditovich@daynix.com, Andrew <andrew@daynix.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew <andrew@daynix.com>

Also, added maintainers information.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 MAINTAINERS       |   6 +++
 docs/ebpf.rst     |  29 +++++++++++
 docs/ebpf_rss.rst | 129 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 docs/ebpf.rst
 create mode 100644 docs/ebpf_rss.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c22bbca5a..464b3f3c95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3111,6 +3111,12 @@ S: Maintained
 F: hw/semihosting/
 F: include/hw/semihosting/
 
+EBPF:
+M: Andrew Melnychenko <andrew@daynix.com>
+M: Yuri Benditovich <yuri.benditovich@daynix.com>
+S: Maintained
+F: ebpf/*
+
 Build and test automation
 -------------------------
 Build and test automation
diff --git a/docs/ebpf.rst b/docs/ebpf.rst
new file mode 100644
index 0000000000..e45d085432
--- /dev/null
+++ b/docs/ebpf.rst
@@ -0,0 +1,29 @@
+===========================
+eBPF qemu support
+===========================
+
+eBPF support (CONFIG_EBPF) is enabled automatically by 'configure' script
+if 'bpf' system call is available.
+To disable eBPF support use './configure --disable-bpf'
+
+Basic eBPF functionality is located in ebpf/ebpf.c and ebpf/ebpf.h.
+There are basic functions to load the eBPF program into the kernel.
+Mostly, functions name are self-explanatory:
+
+- `bpf_create_map()`, `bpf_lookup_element()`, `bpf_update_element()`, `bpf_delete_element()` - manages eBPF maps. On error, a basic error message would be reported and returned -1. On success, 0 would be returned(`bpf_create_map()` returns map's file descriptor).
+- `bpf_prog_load()` - load the program. The program has to have proper map file descriptors if there are used. On error - the log eBPF would be reported. On success, the program file descriptor returned.
+- `bpf_fixup_mapfd()` - would place map file descriptor into the program according to 'relocate array' of 'struct fixup_mapfd_t'. The function would return how many instructions were 'fixed' aka how many relocations was occurred.
+
+Simplified workflow would look like this:
+
+.. code:: C
+
+    int map1 = bpf_create_map(...);
+    int map2 = bpf_create_map(...);
+
+    bpf_fixup_mapfd(<fixup table>, ARRAY_SIZE(<fixup table>), <instructions pointer>, ARRAY_SIZE(<instructions pointer>), <map1 name>, map1);
+    bpf_fixup_mapfd(<fixup table>, ARRAY_SIZE(<fixup table>), <instructions pointer>, ARRAY_SIZE(<instructions pointer>), <map2 name>, map2);
+
+    int prog = bpf_prog_load(<program type>, <instructions pointer>, ARRAY_SIZE(<instructions pointer>), "GPL");
+
+See the bpf(2) for details.
diff --git a/docs/ebpf_rss.rst b/docs/ebpf_rss.rst
new file mode 100644
index 0000000000..96fee391b8
--- /dev/null
+++ b/docs/ebpf_rss.rst
@@ -0,0 +1,129 @@
+===========================
+eBPF RSS virtio-net support
+===========================
+
+RSS(Receive Side Scaling) is used to distribute network packets to guest virtqueues
+by calculating packet hash. Usually every queue is processed then by a specific guest CPU core.
+
+For now there are 2 RSS implementations in qemu:
+- 'software' RSS (functions if qemu receives network packets, i.e. vhost=off)
+- eBPF RSS (can function with also with vhost=on)
+
+If steering BPF is not set for kernel's TUN module, the TUN uses automatic selection
+of rx virtqueue based on lookup table built according to calculated symmetric hash
+of transmitted packets.
+If steering BPF is set for TUN the BPF code calculates the hash of packet header and
+returns the virtqueue number to place the packet to.
+
+Simplified decision formula:
+
+.. code:: C
+
+    queue_index = indirection_table[hash(<packet data>)%<indirection_table size>]
+
+
+Not for all packets, the hash can/should be calculated.
+
+Note: currently, eBPF RSS does not support hash reporting.
+
+eBPF RSS turned on by different combinations of vhost-net, vitrio-net and tap configurations:
+
+- eBPF is used:
+
+        tap,vhost=off & virtio-net-pci,rss=on,hash=off
+
+- eBPF is used:
+
+        tap,vhost=on & virtio-net-pci,rss=on,hash=off
+
+- 'software' RSS is used:
+
+        tap,vhost=off & virtio-net-pci,rss=on,hash=on
+
+- eBPF is used, hash population feature is not reported to the guest:
+
+        tap,vhost=on & virtio-net-pci,rss=on,hash=on
+
+If CONFIG_EBPF is not set then only 'software' RSS is supported.
+Also 'software' RSS, as a fallback, is used if the eBPF program failed to load or set to TUN.
+
+RSS eBPF program
+----------------
+
+RSS program located in ebpf/tun_rss_steering.h as an array of 'struct bpf_insn'.
+So the program is part of the qemu binary.
+Initially, the eBPF program was compiled by clang and source code located at ebpf/rss.bpf.c.
+Prerequisites to recompile the eBPF program (regenerate ebpf/tun_rss_steering.h):
+
+        llvm, clang, kernel source tree, python3 + (pip3 pyelftools)
+        Adjust 'linuxhdrs' in Makefile.ebpf to reflect the location of the kernel source tree
+
+        $ cd ebpf
+        $ make -f Makefile.ebpf
+
+Note the python script for convertation from eBPF ELF object to '.h' file - Ebpf_to_C.py:
+
+        $ python EbpfElf_to_C.py rss.bpf.o tun_rss_steering
+
+The first argument of the script is ELF object, second - section name where the eBPF program located.
+The script would generate <section name>.h file with eBPF instructions and 'relocate array'.
+'relocate array' is an array of 'struct fixup_mapfd_t' with the name of the eBPF map and instruction offset where the file descriptor of the map should be placed.
+
+Current eBPF RSS implementation uses 'bounded loops' with 'backward jump instructions' which present in the last kernels.
+Overall eBPF RSS works on kernels 5.8+.
+
+eBPF RSS implementation
+-----------------------
+
+eBPF RSS loading functionality located in ebpf/ebpf_rss.c and ebpf/ebpf_rss.h.
+
+The `struct EBPFRSSContext` structure that holds 4 file descriptors:
+
+- program_fd - file descriptor of the eBPF RSS program.
+- map_configuration - file descriptor of the 'configuration' map. This map contains one element of 'struct EBPFRSSConfig'. This configuration determines eBPF program behavior.
+- map_toeplitz_key - file descriptor of the 'Toeplitz key' map. One element of the 40byte key prepared for the hashing algorithm.
+- map_indirections_table - 128 elements of queue indexes.
+
+`struct EBPFRSSConfig` fields:
+
+- redirect - "boolean" value, should the hash be calculated, on false  - `default_queue` would be used as the final decision.
+- populate_hash - for now, not used. eBPF RSS doesn't support hash reporting.
+- hash_types - binary mask of different hash types. See `VIRTIO_NET_RSS_HASH_TYPE_*` defines. If for packet hash should not be calculated - `default_queue` would be used.
+- indirections_len - length of the indirections table, maximum 128.
+- default_queue - the queue index that used for packet that shouldn't be hashed. For some packets, the hash can't be calculated(g.e ARP).
+
+Functions:
+
+- `ebpf_rss_init()` - sets program_fd to -1, which indicates that EBPFRSSContext is not loaded.
+- `ebpf_rss_load()` - creates 3 maps and loads eBPF program from tun_rss_steering.h. Returns 'true' on success. After that, program_fd can be used to set steering for TAP.
+- `ebpf_rss_set_all()` - sets values for eBPF maps. `indirections_table` length is in EBPFRSSConfig. `toeplitz_key` is VIRTIO_NET_RSS_MAX_KEY_SIZE aka 40 bytes array.
+- `ebpf_rss_unload()` - close all file descriptors and set program_fd to -1.
+
+Simplified eBPF RSS workflow:
+
+.. code:: C
+
+    struct EBPFRSSConfig config;
+    config.redirect = 1;
+    config.hash_types = VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | VIRTIO_NET_RSS_HASH_TYPE_TCPv4;
+    config.indirections_len = VIRTIO_NET_RSS_MAX_TABLE_LEN;
+    config.default_queue = 0;
+
+    uint16_t table[VIRTIO_NET_RSS_MAX_TABLE_LEN] = {...};
+    uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE] = {...};
+
+    struct EBPFRSSContext ctx;
+    ebpf_rss_init(&ctx);
+    ebpf_rss_load(&ctx);
+    ebpf_rss_set_all(&ctx, &config, table, key);
+    if (net_client->info->set_steering_ebpf != NULL) {
+        net_client->info->set_steering_ebpf(net_client, ctx->program_fd);
+    }
+    ...
+    ebpf_unload(&ctx);
+
+
+NetClientState SetSteeringEBPF()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For now, `set_steering_ebpf()` method supported by Linux TAP NetClientState. The method requires an eBPF program file descriptor as an argument.
-- 
2.28.0


