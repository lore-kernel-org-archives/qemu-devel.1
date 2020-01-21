Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250CCC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D239C207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuFnKdbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D239C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvgU-0006Ij-0t
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itvfA-0004pU-1f
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itvf5-0005ki-Rv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:41:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57757
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itvf5-0005iJ-KV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579621308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjOu0u5Xok23tQVg48xBBlmaWJ2dx0gx9+/mzisFd2w=;
 b=TuFnKdbQF7/iGI2vPARAeuTUoPsSicdgOtVEzEoB91kpEOe16oC3JL3babJ4Dqx6bxM823
 Ud+tzZYOQ+JkE22fKS/QbbS4SycWcQYSqxBvSUav2KWmmdCWlwAqbuhqvDGSGrm4zSYTcD
 jQC/i/cdtLto3nnvGCt65IAUNwVC+qg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-BApM-WMhP3uS2Pf0u07Pwg-1; Tue, 21 Jan 2020 10:41:44 -0500
Received: by mail-wr1-f72.google.com with SMTP id d8so1466735wrq.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 07:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rjOu0u5Xok23tQVg48xBBlmaWJ2dx0gx9+/mzisFd2w=;
 b=rIoZerVyxENK8ocQA5TIPDqpm+j8YAD1Zp7rTLpN7eBJ9ePXozx07r4+teLa3EuDj5
 xc7QWJI2hohLFqIY87YWZ/GxUy2vY4iRy0uXpwJAnNHo/qNtbhSqyIs3hqP2EwADRkwN
 RszcQ2ztxNAYEdEepsGnx4jI7iwErFk6WRqZcB97EtMEn6cKiS7kKB5OqUAZ2aD8rJid
 oRiwUQmQdfXkg0sFG93WgLiBctLBaW1TBzfF0pOZiTpwGcOtB6mzomu/rSb+Ce5Jend/
 NhRqYA5CGug0kujBwmPto9beQnpzDsuH+DLj1enuqTmu/S9H1fMRBo3SKKZzLIn/7Nya
 ku6g==
X-Gm-Message-State: APjAAAVi2AV+9/RDiDMAtoBqhi4oog2WEmVlq7c+tbquoThOC0aP94B/
 RUwTwFNfarxSz9JygP9WFpLOoMGjyFpRdg8oK1kkSj4b6jbGVmshcxIMHtmtfAr3Ad3zu2gAPlZ
 ho6amkNCvXHwhs3A=
X-Received: by 2002:a1c:2355:: with SMTP id j82mr4804327wmj.135.1579621302347; 
 Tue, 21 Jan 2020 07:41:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzffhywUeiwIfW4h3vp7z72v0ORa78f2KJ5F2oWOcD6p1VT3cmEpmFEYedXpS+nTcicly53/w==
X-Received: by 2002:a1c:2355:: with SMTP id j82mr4804301wmj.135.1579621301948; 
 Tue, 21 Jan 2020 07:41:41 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q6sm55955987wrx.72.2020.01.21.07.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 07:41:41 -0800 (PST)
Subject: Re: [PATCH v2 000/109] virtiofs daemon [all]
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a2099661-8c69-5cdb-2b17-21bf0842c8f5@redhat.com>
Date: Tue, 21 Jan 2020 16:41:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: BApM-WMhP3uS2Pf0u07Pwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 1:22 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>    This is a full set for virtiofsd - a daemon
> that implements the user space side of virtiofs.
> 
> I've addressed most review comments from V1; we've got
> 95 Reviewed-by's out of 110 - I'd like to get a PULL out ASAP.
> 
> The set pulls in a big chunk of the upstream libfuse library
> (unmodified so that it's easy to check it really is upstream),
> chops all the stuff out we don't need and then adds the
> new transport we need.  I've formatted everything into qemu's code style -
> using indent and the clang tools for the files I've imported.
> 
> We can't just link with libfuse, since we have to make ABI incompatible
> changes for the new transport and it's quite invasive; the library is
> designed to be the basis for multiple filesystems, but all on the same
> transport.
> 
> Running this daemon is typically done with:
> 
>     ./virtiofsd --socket-path=/path/socket -o source=/path/to/fs
> 
> connected to a qemu that's then started with:
>     -chardev socket,id=char0,path=/path/socket -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=myfs
> 
> and then in the guest mount with:
>     mount -t virtiofs myfs /mnt
> 
> Our development branch is: https://gitlab.com/virtio-fs/qemu/tree/virtio-fs-dev

FWIW this branch contains more than this series, because it failed to 
build on 32-bit:

$ make virtiofsd
   CC      tools/virtiofsd/fuse_lowlevel.o
tools/virtiofsd/fuse_lowlevel.c: In function 'do_removemapping':
tools/virtiofsd/fuse_lowlevel.c:1956:60: error: format '%ld' expects 
argument of type 'long int', but argument 4 has type 'unsigned int' 
[-Werror=format=]
              "do_removemapping: invalid in, expected %d * %ld, has %ld 
- %ld\n",
                                                             ^
tools/virtiofsd/fuse_lowlevel.c:1956:69: error: format '%ld' expects 
argument of type 'long int', but argument 5 has type 'size_t {aka 
unsigned int}' [-Werror=format=]
              "do_removemapping: invalid in, expected %d * %ld, has %ld 
- %ld\n",
                                                                      ^
tools/virtiofsd/fuse_lowlevel.c:1956:75: error: format '%ld' expects 
argument of type 'long int', but argument 6 has type 'size_t {aka 
unsigned int}' [-Werror=format=]
              "do_removemapping: invalid in, expected %d * %ld, has %ld 
- %ld\n",
 
    ^

And the offending patch is not included in the 109:

$ git show 62d82cfbe5a
commit 62d82cfbe5a2ad05ae3215f2461b76aa9915108d
Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
Date:   Fri Jul 6 18:03:49 2018 +0100

     DAX: virtiofsd: Add setup/remove mappings fuse commands

Consider pushing tags with version, so it is easier to diff 
(virtio-fs-dev got force-pushed).


We don't need libslirp/capstone/dtc but they are still built:

$ make virtiofsd
   GEN     config-host.h
make[1]: Entering directory 'slirp'
   CC      slirp/src/state.o
   CC      slirp/src/tcp_timer.o
   CC      slirp/src/dhcpv6.o
   CC      slirp/src/ip_input.o
   CC      slirp/src/ip6_icmp.o
   CC      slirp/src/bootp.o
   CC      slirp/src/ip6_input.o
   CC      slirp/src/slirp.o
   CC      slirp/src/vmstate.o
   CC      slirp/src/ip_output.o
   CC      slirp/src/ncsi.o
   CC      slirp/src/tcp_output.o
   CC      slirp/src/ndp_table.o
   CC      slirp/src/version.o
   CC      slirp/src/misc.o
   CC      slirp/src/ip6_output.o
   CC      slirp/src/mbuf.o
   CC      slirp/src/tftp.o
   CC      slirp/src/arp_table.o
   CC      slirp/src/util.o
   CC      slirp/src/socket.o
   CC      slirp/src/sbuf.o
   CC      slirp/src/stream.o
   CC      slirp/src/dnssearch.o
   CC      slirp/src/udp.o
   CC      slirp/src/tcp_input.o
   CC      slirp/src/if.o
   CC      slirp/src/cksum.o
   CC      slirp/src/tcp_subr.o
   CC      slirp/src/udp6.o
   CC      slirp/src/ip_icmp.o
   AR      slirp/libslirp.a
make[1]: Leaving directory 'slirp'
          DEP dtc/libfdt/fdt_overlay.c
          DEP dtc/libfdt/fdt_addresses.c
          DEP dtc/libfdt/fdt_empty_tree.c
          DEP dtc/libfdt/fdt_strerror.c
          DEP dtc/libfdt/fdt_rw.c
          DEP dtc/libfdt/fdt_sw.c
          DEP dtc/libfdt/fdt_wip.c
          DEP dtc/libfdt/fdt_ro.c
          DEP dtc/libfdt/fdt.c
          DEP dtc/util.c
          DEP dtc/fdtoverlay.c
          DEP dtc/fdtput.c
          DEP dtc/fdtget.c
          DEP dtc/fdtdump.c
          DEP convert-dtsv0-lexer.lex.c
          DEP dtc/srcpos.c
          BISON dtc-parser.tab.c
          DEP dtc-parser.tab.c
          LEX dtc-lexer.lex.c
          DEP dtc-lexer.lex.c
          DEP dtc/treesource.c
          DEP dtc/livetree.c
          DEP dtc/fstree.c
          DEP dtc/flattree.c
          DEP dtc/dtc.c
          DEP dtc/data.c
          DEP dtc/checks.c
          CC libfdt/fdt.o
          CC libfdt/fdt_ro.o
          CC libfdt/fdt_wip.o
          CC libfdt/fdt_sw.o
          CC libfdt/fdt_rw.o
          CC libfdt/fdt_strerror.o
          CC libfdt/fdt_empty_tree.o
          CC libfdt/fdt_addresses.o
          CC libfdt/fdt_overlay.o
          AR libfdt/libfdt.a
arm-linux-gnueabihf-ar: creating libfdt/libfdt.a
a - libfdt/fdt.o
a - libfdt/fdt_ro.o
a - libfdt/fdt_wip.o
a - libfdt/fdt_sw.o
a - libfdt/fdt_rw.o
a - libfdt/fdt_strerror.o
a - libfdt/fdt_empty_tree.o
a - libfdt/fdt_addresses.o
a - libfdt/fdt_overlay.o
   CC      cs.o
   CC      utils.o
   CC      SStream.o
   CC      MCInstrDesc.o
   CC      MCRegisterInfo.o
   CC      arch/ARM/ARMDisassembler.o
   CC      arch/ARM/ARMInstPrinter.o
   CC      arch/ARM/ARMMapping.o
   CC      arch/ARM/ARMModule.o
   CC      arch/AArch64/AArch64BaseInfo.o
   CC      arch/AArch64/AArch64Disassembler.o
   CC      arch/AArch64/AArch64InstPrinter.o
   CC      arch/AArch64/AArch64Mapping.o
   CC      arch/AArch64/AArch64Module.o
   CC      arch/Mips/MipsDisassembler.o
   CC      arch/Mips/MipsInstPrinter.o
   CC      arch/Mips/MipsMapping.o
   CC      arch/Mips/MipsModule.o
   CC      arch/PowerPC/PPCDisassembler.o
   CC      arch/PowerPC/PPCInstPrinter.o
   CC      arch/PowerPC/PPCMapping.o
   CC      arch/PowerPC/PPCModule.o
   CC      arch/Sparc/SparcDisassembler.o
   CC      arch/Sparc/SparcInstPrinter.o
   CC      arch/Sparc/SparcMapping.o
   CC      arch/Sparc/SparcModule.o
   CC      arch/SystemZ/SystemZDisassembler.o
   CC      arch/SystemZ/SystemZInstPrinter.o
   CC      arch/SystemZ/SystemZMapping.o
   CC      arch/SystemZ/SystemZModule.o
   CC      arch/SystemZ/SystemZMCTargetDesc.o
   CC      arch/X86/X86DisassemblerDecoder.o
   CC      arch/X86/X86Disassembler.o
   CC      arch/X86/X86IntelInstPrinter.o
   CC      arch/X86/X86ATTInstPrinter.o
   CC      arch/X86/X86Mapping.o
   CC      arch/X86/X86Module.o
   CC      arch/XCore/XCoreDisassembler.o
   CC      arch/XCore/XCoreInstPrinter.o
   CC      arch/XCore/XCoreMapping.o
   CC      arch/XCore/XCoreModule.o
   CC      MCInst.o
   AR      libcapstone.a
   CC      tools/virtiofsd/buffer.o
   CC      tools/virtiofsd/fuse_opt.o
   CC      tools/virtiofsd/fuse_log.o
   CC      tools/virtiofsd/fuse_lowlevel.o
   ...

FYI Paolo queued this patch, so libfdt shouldn't get compiled anymore:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg671667.html

> This code is going into tools/virtiofsd  based on the previous long
> discussion.
> 
> Thank you to all those who have contributed code and to those who have
> reviewed the previous version.
> 
> Dave
> 
> Dr. David Alan Gilbert (35):
>    virtiofsd: Pull in upstream headers
>    virtiofsd: Pull in kernel's fuse.h
>    virtiofsd: Add auxiliary .c's
>    virtiofsd: Add fuse_lowlevel.c
>    virtiofsd: Add passthrough_ll
>    virtiofsd: Trim down imported files
>    virtiofsd: Format imported files to qemu style
>    virtiofsd: Fix fuse_daemonize ignored return values
>    virtiofsd: Fix common header and define for QEMU builds
>    virtiofsd: Trim out compatibility code
>    virtiofsd: Add options for virtio
>    virtiofsd: Open vhost connection instead of mounting
>    virtiofsd: Start wiring up vhost-user
>    virtiofsd: Add main virtio loop
>    virtiofsd: get/set features callbacks
>    virtiofsd: Start queue threads
>    virtiofsd: Poll kick_fd for queue
>    virtiofsd: Start reading commands from queue
>    virtiofsd: Send replies to messages
>    virtiofsd: Keep track of replies
>    virtiofsd: Add Makefile wiring for virtiofsd contrib
>    virtiofsd: Fast path for virtio read
>    virtiofs: Add maintainers entry
>    virtiofsd: Plumb fuse_bufvec through to do_write_buf
>    virtiofsd: Pass write iov's all the way through
>    virtiofsd: cap-ng helpers
>    docs:  Add docs/tools
>    virtiofsd: Handle reinit
>    virtiofsd: Handle hard reboot
>    virtiofsd: Kill threads when queues are stopped
>    vhost-user: Print unexpected slave message types
>    contrib/libvhost-user: Protect slave fd with mutex
>    virtiofsd: Clean up inodes on destroy
>    libvhost-user: Fix some memtable remap cases
>    virtiofsd: Convert lo_destroy to take the lo->mutex lock itself
> 
> Eric Ren (1):
>    virtiofsd: fix incorrect error handling in lo_do_lookup
> 
> Eryu Guan (3):
>    virtiofsd: print log only when priority is high enough
>    virtiofsd: convert more fprintf and perror to use fuse log infra
>    virtiofsd: stop all queue threads on exit in virtio_loop()
> 
> Jiufei Xue (1):
>    virtiofsd: support nanosecond resolution for file timestamp
> 
> Liu Bo (6):
>    virtiofsd: fix error handling in main()
>    virtiofsd: cleanup allocated resource in se
>    virtiofsd: fix memory leak on lo.source
>    virtiofsd: add helper for lo_data cleanup
>    virtiofsd: enable PARALLEL_DIROPS during INIT
>    Virtiofsd: fix memory leak on fuse queueinfo
> 
> Masayoshi Mizuma (4):
>    virtiofsd: Add ID to the log with FUSE_LOG_DEBUG level
>    virtiofsd: Add timestamp to the log with FUSE_LOG_DEBUG level
>    virtiofsd: Prevent multiply running with same vhost_user_socket
>    virtiofsd: add some options to the help message
> 
> Miklos Szeredi (10):
>    virtiofsd: passthrough_ll: add fallback for racy ops
>    virtiofsd: passthrough_ll: add renameat2 support
>    virtiofsd: passthrough_ll: disable readdirplus on cache=never
>    virtiofsd: passthrough_ll: control readdirplus
>    virtiofsd: rename unref_inode() to unref_inode_lolocked()
>    virtiofsd: fail when parent inode isn't known in lo_do_lookup()
>    virtiofsd: extract root inode init into setup_root()
>    virtiofsd: passthrough_ll: clean up cache related options
>    virtiofsd: passthrough_ll: use hashtable
>    virtiofsd: passthrough_ll: fix refcounting on remove/rename
> 
> Misono Tomohiro (1):
>    virtiofsd: Fix data corruption with O_APPEND write in writeback mode
> 
> Peng Tao (1):
>    virtiofsd: do not always set FUSE_FLOCK_LOCKS
> 
> Stefan Hajnoczi (37):
>    virtiofsd: remove mountpoint dummy argument
>    virtiofsd: remove unused notify reply support
>    virtiofsd: add -o source=PATH to help output
>    virtiofsd: add --fd=FDNUM fd passing option
>    virtiofsd: make -f (foreground) the default
>    virtiofsd: add vhost-user.json file
>    virtiofsd: add --print-capabilities option
>    virtiofsd: passthrough_ll: add lo_map for ino/fh indirection
>    virtiofsd: passthrough_ll: add ino_map to hide lo_inode pointers
>    virtiofsd: passthrough_ll: add dirp_map to hide lo_dirp pointers
>    virtiofsd: passthrough_ll: add fd_map to hide file descriptors
>    virtiofsd: validate path components
>    virtiofsd: add fuse_mbuf_iter API
>    virtiofsd: validate input buffer sizes in do_write_buf()
>    virtiofsd: check input buffer size in fuse_lowlevel.c ops
>    virtiofsd: prevent ".." escape in lo_do_lookup()
>    virtiofsd: prevent ".." escape in lo_do_readdir()
>    virtiofsd: use /proc/self/fd/ O_PATH file descriptor
>    virtiofsd: sandbox mount namespace
>    virtiofsd: move to an empty network namespace
>    virtiofsd: move to a new pid namespace
>    virtiofsd: add seccomp whitelist
>    virtiofsd: set maximum RLIMIT_NOFILE limit
>    virtiofsd: fix libfuse information leaks
>    virtiofsd: add security guide document
>    virtiofsd: add --syslog command-line option
>    virtiofsd: use fuse_lowlevel_is_virtio() in fuse_session_destroy()
>    virtiofsd: prevent fv_queue_thread() vs virtio_loop() races
>    virtiofsd: make lo_release() atomic
>    virtiofsd: prevent races with lo_dirp_put()
>    virtiofsd: rename inode->refcount to inode->nlookup
>    virtiofsd: add man page
>    virtiofsd: introduce inode refcount to prevent use-after-free
>    virtiofsd: process requests in a thread pool
>    virtiofsd: prevent FUSE_INIT/FUSE_DESTROY races
>    virtiofsd: fix lo_destroy() resource leaks
>    virtiofsd: add --thread-pool-size=NUM option
> 
> Vivek Goyal (6):
>    virtiofsd: Make fsync work even if only inode is passed in
>    virtiofsd: passthrough_ll: create new files in caller's context
>    virtiofsd: Parse flag FUSE_WRITE_KILL_PRIV
>    virtiofsd: Drop CAP_FSETID if client asked for it
>    virtiofsd: Support remote posix locks
>    virtiofsd: Reset O_DIRECT flag during file open
> 
> Xiao Yang (2):
>    vitriofsd/passthrough_ll: fix fallocate() ifdefs
>    virtiofsd/passthrough_ll: Pass errno to fuse_reply_err()
> 
> piaojun (2):
>    virtiofsd: add definition of fuse_buf_writev()
>    virtiofsd: use fuse_buf_writev to replace fuse_buf_write for better
>      performance
> 
>   .gitignore                                |    1 +
>   MAINTAINERS                               |    8 +
>   Makefile                                  |   27 +-
>   Makefile.objs                             |    1 +
>   configure                                 |   16 +
>   contrib/libvhost-user/libvhost-user.c     |   57 +-
>   contrib/libvhost-user/libvhost-user.h     |    6 +
>   docs/index.rst                            |    1 +
>   docs/interop/vhost-user.json              |    4 +-
>   docs/tools/conf.py                        |   16 +
>   docs/tools/index.rst                      |   14 +
>   docs/tools/virtiofsd-security.rst         |  118 +
>   hw/virtio/vhost-user.c                    |    2 +-
>   include/standard-headers/linux/fuse.h     |  891 ++++++
>   scripts/update-linux-headers.sh           |    1 +
>   tools/virtiofsd/50-qemu-virtiofsd.json.in |    5 +
>   tools/virtiofsd/Makefile.objs             |   12 +
>   tools/virtiofsd/buffer.c                  |  351 +++
>   tools/virtiofsd/fuse.h                    | 1249 +++++++++
>   tools/virtiofsd/fuse_common.h             |  860 ++++++
>   tools/virtiofsd/fuse_i.h                  |  115 +
>   tools/virtiofsd/fuse_log.c                |   40 +
>   tools/virtiofsd/fuse_log.h                |   74 +
>   tools/virtiofsd/fuse_lowlevel.c           | 2779 +++++++++++++++++++
>   tools/virtiofsd/fuse_lowlevel.h           | 2023 ++++++++++++++
>   tools/virtiofsd/fuse_misc.h               |   60 +
>   tools/virtiofsd/fuse_opt.c                |  449 +++
>   tools/virtiofsd/fuse_opt.h                |  272 ++
>   tools/virtiofsd/fuse_signals.c            |   97 +
>   tools/virtiofsd/fuse_virtio.c             |  985 +++++++
>   tools/virtiofsd/fuse_virtio.h             |   33 +
>   tools/virtiofsd/helper.c                  |  349 +++
>   tools/virtiofsd/passthrough_helpers.h     |   51 +
>   tools/virtiofsd/passthrough_ll.c          | 3006 +++++++++++++++++++++
>   tools/virtiofsd/seccomp.c                 |  164 ++
>   tools/virtiofsd/seccomp.h                 |   16 +
>   tools/virtiofsd/virtiofsd.texi            |  104 +
>   37 files changed, 14242 insertions(+), 15 deletions(-)
>   create mode 100644 docs/tools/conf.py
>   create mode 100644 docs/tools/index.rst
>   create mode 100644 docs/tools/virtiofsd-security.rst
>   create mode 100644 include/standard-headers/linux/fuse.h
>   create mode 100644 tools/virtiofsd/50-qemu-virtiofsd.json.in
>   create mode 100644 tools/virtiofsd/Makefile.objs
>   create mode 100644 tools/virtiofsd/buffer.c
>   create mode 100644 tools/virtiofsd/fuse.h
>   create mode 100644 tools/virtiofsd/fuse_common.h
>   create mode 100644 tools/virtiofsd/fuse_i.h
>   create mode 100644 tools/virtiofsd/fuse_log.c
>   create mode 100644 tools/virtiofsd/fuse_log.h
>   create mode 100644 tools/virtiofsd/fuse_lowlevel.c
>   create mode 100644 tools/virtiofsd/fuse_lowlevel.h
>   create mode 100644 tools/virtiofsd/fuse_misc.h
>   create mode 100644 tools/virtiofsd/fuse_opt.c
>   create mode 100644 tools/virtiofsd/fuse_opt.h
>   create mode 100644 tools/virtiofsd/fuse_signals.c
>   create mode 100644 tools/virtiofsd/fuse_virtio.c
>   create mode 100644 tools/virtiofsd/fuse_virtio.h
>   create mode 100644 tools/virtiofsd/helper.c
>   create mode 100644 tools/virtiofsd/passthrough_helpers.h
>   create mode 100644 tools/virtiofsd/passthrough_ll.c
>   create mode 100644 tools/virtiofsd/seccomp.c
>   create mode 100644 tools/virtiofsd/seccomp.h
>   create mode 100644 tools/virtiofsd/virtiofsd.texi
> 


