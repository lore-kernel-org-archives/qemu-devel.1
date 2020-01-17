Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A42C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C997D2072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FK4jGHP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C997D2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isXMV-00008D-JX
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 14:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40068)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3zgoiXgMKCmMKLaHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--jkz.bounces.google.com>)
 id 1isXI2-0004Mh-Uu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3zgoiXgMKCmMKLaHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--jkz.bounces.google.com>)
 id 1isXI1-0003su-3u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:18 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a]:39576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3zgoiXgMKCmMKLaHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--jkz.bounces.google.com>)
 id 1isXI0-0003rX-SR
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:17 -0500
Received: by mail-pj1-x104a.google.com with SMTP id c67so5047570pje.4
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Ywt1fC31l3tgfaEODEwZJJAObS0vfg3b7/nZB+f1lOk=;
 b=FK4jGHP13Fz//X83V3+tHl+xRXFDpbdnTfkKpmlsyax12rSs/F43lQUX+5bLn3pogZ
 dvpzQdz/LrYNxgA0pgJnGG0M+EHwIpFlj6YZPE4/oojRc/n6q2K9uAUkqrzKDh5+zKvA
 Drp/ieTQBCIkMpRWzqAEN8vx30/2qcc5GdHhb3QKVPlKrkQpo1quyGC/AZzUtkol/jif
 H/WP/l0gyFFtgdAMThJPQlkLqmXxlafPMET+salvQbB1zVL7X+M91b8f9pQbvxLRzTgM
 1A/fXko1avTFWyZqjLz38ePpUGUoVkJ+qajd8pHMq5OrAEPiQjsn9mKxG+byKBs0P6O1
 RwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Ywt1fC31l3tgfaEODEwZJJAObS0vfg3b7/nZB+f1lOk=;
 b=DSGFuWvIyRqk0yYxBsYNU+KZO+xQ3lLl5+SOwKCaaLzRWhxTFPGe8kKYdT7IOdTLRq
 KG1CHrxnclpo65RYwhF+sWmQF90JXlbLRMe1Z8+4I+6icnszWSKl1GrtuQNgJ1lMqT10
 nRIoEGJoxaGwoC8Tvgd6EHQDEP3B7gg4c/YEBC2lGUKndFBTkyO4NnVnmIXGXvm4G1SB
 40wzf8ObtWQpa9Rr4PSoOooS9GkVlgyhrH0nJalXt6QBt3MbxBNREwCqUzl0WMyW9s71
 PGMxw1H7WIfgARUHHYJuH3q0T94QW9lvjv9OJkbfjb9Kj5A9Hr3aOmqVA/RJvPQzMkX9
 Twmg==
X-Gm-Message-State: APjAAAXwwskuE+ow/Tb6Y16j/4L/4lPDiLLYqab79wHLeaz0KZyNcmas
 8vYiTXWmavGqtFX7upzMhj8Ut5i+tUx8vpJHQPBYEXtK4cAJ9+7Qe623vw0+Ak5sECMwghsOQnX
 DinhLQcvxaI0uIQdYuhxG9i+UR9BzoXHh/ZIn473mGJd+3npxh/EH
X-Google-Smtp-Source: APXvYqwauwe3001NsnkCaf9QpoXVJapdMOR+McN4vx5Ob148w9yxeBhqHVUO2GBKBPy2q5jD17SR2xc=
X-Received: by 2002:a63:da14:: with SMTP id c20mr48421165pgh.280.1579289294847; 
 Fri, 17 Jan 2020 11:28:14 -0800 (PST)
Date: Fri, 17 Jan 2020 11:28:05 -0800
In-Reply-To: <20200117192808.129398-1-jkz@google.com>
Message-Id: <20200117192808.129398-2-jkz@google.com>
Mime-Version: 1.0
References: <20200117192808.129398-1-jkz@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 1/4] linux-user: Use `qemu_log' for non-strace logging
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, imp@bsdimp.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::104a
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

Since most calls to `gemu_log` are actually logging unimplemented features,
this change replaces most non-strace calls to `gemu_log` with calls to
`qemu_log_mask(LOG_UNIMP, ...)`.  This allows the user to easily log to
a file, and to mask out these log messages if they desire.

Note: This change is slightly backwards incompatible, since now these
"unimplemented" log messages will not be logged by default.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/arm/cpu_loop.c |  5 ++--
 linux-user/fd-trans.c     | 55 +++++++++++++++++++++++++--------------
 linux-user/syscall.c      | 55 +++++++++++++++++++++------------------
 linux-user/vm86.c         |  3 ++-
 4 files changed, 69 insertions(+), 49 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 1fae90c6df..cf618daa1c 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -349,8 +349,9 @@ void cpu_loop(CPUARMState *env)
                             env->regs[0] = cpu_get_tls(env);
                             break;
                         default:
-                            gemu_log("qemu: Unsupported ARM syscall: 0x%x\n",
-                                     n);
+                            qemu_log_mask(LOG_UNIMP,
+                                          "qemu: Unsupported ARM syscall: 0x%x\n",
+                                          n);
                             env->regs[0] = -TARGET_ENOSYS;
                             break;
                         }
diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 9b92386abf..c0687c52e6 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -514,7 +514,8 @@ static abi_long host_to_target_data_bridge_nlattr(struct nlattr *nlattr,
         u32[1] = tswap32(u32[1]); /* optmask */
         break;
     default:
-        gemu_log("Unknown QEMU_IFLA_BR type %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_BR type %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -577,7 +578,8 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BRPORT_BRIDGE_ID:
         break;
     default:
-        gemu_log("Unknown QEMU_IFLA_BRPORT type %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_BRPORT type %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -605,7 +607,8 @@ static abi_long host_to_target_data_tun_nlattr(struct nlattr *nlattr,
         *u32 = tswap32(*u32);
         break;
     default:
-        gemu_log("Unknown QEMU_IFLA_TUN type %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_TUN type %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -652,7 +655,8 @@ static abi_long host_to_target_data_linkinfo_nlattr(struct nlattr *nlattr,
                                                   NULL,
                                                 host_to_target_data_tun_nlattr);
         } else {
-            gemu_log("Unknown QEMU_IFLA_INFO_KIND %s\n", li_context->name);
+            qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_INFO_KIND %s\n",
+                          li_context->name);
         }
         break;
     case QEMU_IFLA_INFO_SLAVE_DATA:
@@ -663,12 +667,13 @@ static abi_long host_to_target_data_linkinfo_nlattr(struct nlattr *nlattr,
                                                   NULL,
                                        host_to_target_slave_data_bridge_nlattr);
         } else {
-            gemu_log("Unknown QEMU_IFLA_INFO_SLAVE_KIND %s\n",
+            qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_INFO_SLAVE_KIND %s\n",
                      li_context->slave_name);
         }
         break;
     default:
-        gemu_log("Unknown host QEMU_IFLA_INFO type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host QEMU_IFLA_INFO type: %d\n",
+                      nlattr->nla_type);
         break;
     }
 
@@ -690,7 +695,8 @@ static abi_long host_to_target_data_inet_nlattr(struct nlattr *nlattr,
         }
         break;
     default:
-        gemu_log("Unknown host AF_INET type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host AF_INET type: %d\n",
+                      nlattr->nla_type);
     }
     return 0;
 }
@@ -741,7 +747,8 @@ static abi_long host_to_target_data_inet6_nlattr(struct nlattr *nlattr,
         }
         break;
     default:
-        gemu_log("Unknown host AF_INET6 type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host AF_INET6 type: %d\n",
+                      nlattr->nla_type);
     }
     return 0;
 }
@@ -759,7 +766,8 @@ static abi_long host_to_target_data_spec_nlattr(struct nlattr *nlattr,
                                               NULL,
                                              host_to_target_data_inet6_nlattr);
     default:
-        gemu_log("Unknown host AF_SPEC type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host AF_SPEC type: %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -780,7 +788,8 @@ static abi_long host_to_target_data_xdp_nlattr(struct nlattr *nlattr,
         *u32 = tswap32(*u32);
         break;
     default:
-        gemu_log("Unknown host XDP type: %d\n", nlattr->nla_type);
+        qemu_log_mask(
+            LOG_UNIMP, "Unknown host XDP type: %d\n", nlattr->nla_type);
         break;
     }
     return 0;
@@ -920,7 +929,8 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
                                               NULL,
                                                 host_to_target_data_xdp_nlattr);
     default:
-        gemu_log("Unknown host QEMU_IFLA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host QEMU_IFLA type: %d\n",
+                      rtattr->rta_type);
         break;
     }
     return 0;
@@ -954,7 +964,8 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
         ci->tstamp = tswap32(ci->tstamp);
         break;
     default:
-        gemu_log("Unknown host IFA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(
+            LOG_UNIMP, "Unknown host IFA type: %d\n", rtattr->rta_type);
         break;
     }
     return 0;
@@ -996,7 +1007,8 @@ static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
 #endif
         break;
     default:
-        gemu_log("Unknown host RTA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(
+            LOG_UNIMP, "Unknown host RTA type: %d\n", rtattr->rta_type);
         break;
     }
     return 0;
@@ -1111,7 +1123,8 @@ static abi_long target_to_host_data_link_rtattr(struct rtattr *rtattr)
 {
     switch (rtattr->rta_type) {
     default:
-        gemu_log("Unknown target QEMU_IFLA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown target QEMU_IFLA type: %d\n",
+                      rtattr->rta_type);
         break;
     }
     return 0;
@@ -1125,7 +1138,8 @@ static abi_long target_to_host_data_addr_rtattr(struct rtattr *rtattr)
     case IFA_ADDRESS:
         break;
     default:
-        gemu_log("Unknown target IFA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown target IFA type: %d\n",
+                      rtattr->rta_type);
         break;
     }
     return 0;
@@ -1147,7 +1161,8 @@ static abi_long target_to_host_data_route_rtattr(struct rtattr *rtattr)
         *u32 = tswap32(*u32);
         break;
     default:
-        gemu_log("Unknown target RTA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown target RTA type: %d\n",
+                      rtattr->rta_type);
         break;
     }
     return 0;
@@ -1232,8 +1247,8 @@ static abi_long host_to_target_data_audit(struct nlmsghdr *nlh)
 {
     switch (nlh->nlmsg_type) {
     default:
-        gemu_log("Unknown host audit message type %d\n",
-                 nlh->nlmsg_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host audit message type %d\n",
+                      nlh->nlmsg_type);
         return -TARGET_EINVAL;
     }
     return 0;
@@ -1253,8 +1268,8 @@ static abi_long target_to_host_data_audit(struct nlmsghdr *nlh)
     case AUDIT_FIRST_USER_MSG2 ... AUDIT_LAST_USER_MSG2:
         break;
     default:
-        gemu_log("Unknown target audit message type %d\n",
-                 nlh->nlmsg_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown target audit message type %d\n",
+                      nlh->nlmsg_type);
         return -TARGET_EINVAL;
     }
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 249e4b95fc..629f3a21b5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1545,20 +1545,18 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
             - sizeof(struct target_cmsghdr);
 
         space += CMSG_SPACE(len);
-        if (space > msgh->msg_controllen) {
-            space -= CMSG_SPACE(len);
-            /* This is a QEMU bug, since we allocated the payload
-             * area ourselves (unlike overflow in host-to-target
-             * conversion, which is just the guest giving us a buffer
-             * that's too small). It can't happen for the payload types
-             * we currently support; if it becomes an issue in future
-             * we would need to improve our allocation strategy to
-             * something more intelligent than "twice the size of the
-             * target buffer we're reading from".
-             */
-            gemu_log("Host cmsg overflow\n");
-            break;
-        }
+
+        /*
+         * This is a QEMU bug, since we allocated the payload
+         * area ourselves (unlike overflow in host-to-target
+         * conversion, which is just the guest giving us a buffer
+         * that's too small). It can't happen for the payload types
+         * we currently support; if it becomes an issue in future
+         * we would need to improve our allocation strategy to
+         * something more intelligent than "twice the size of the
+         * target buffer we're reading from".
+         */
+        assert(space > msgh->msg_controllen && "Host cmsg overflow");
 
         if (tswap32(target_cmsg->cmsg_level) == TARGET_SOL_SOCKET) {
             cmsg->cmsg_level = SOL_SOCKET;
@@ -1586,8 +1584,8 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
             __get_user(cred->uid, &target_cred->uid);
             __get_user(cred->gid, &target_cred->gid);
         } else {
-            gemu_log("Unsupported ancillary data: %d/%d\n",
-                                        cmsg->cmsg_level, cmsg->cmsg_type);
+            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+                          cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(data, target_data, len);
         }
 
@@ -1808,8 +1806,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
 
         default:
         unimplemented:
-            gemu_log("Unsupported ancillary data: %d/%d\n",
-                                        cmsg->cmsg_level, cmsg->cmsg_type);
+            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+                          cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(target_data, data, MIN(len, tgt_len));
             if (tgt_len > len) {
                 memset(target_data + len, 0, tgt_len - len);
@@ -2284,7 +2282,8 @@ set_timeout:
 #endif /* SOL_NETLINK */
     default:
     unimplemented:
-        gemu_log("Unsupported setsockopt level=%d optname=%d\n", level, optname);
+        qemu_log_mask(LOG_UNIMP, "Unsupported setsockopt level=%d optname=%d\n",
+                      level, optname);
         ret = -TARGET_ENOPROTOOPT;
     }
     return ret;
@@ -2637,8 +2636,9 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
 #endif /* SOL_NETLINK */
     default:
     unimplemented:
-        gemu_log("getsockopt level=%d optname=%d not yet supported\n",
-                 level, optname);
+        qemu_log_mask(LOG_UNIMP,
+                      "getsockopt level=%d optname=%d not yet supported\n",
+                      level, optname);
         ret = -TARGET_EOPNOTSUPP;
         break;
     }
@@ -3393,7 +3393,7 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
     case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
         return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 1);
     default:
-        gemu_log("Unsupported socketcall: %d\n", num);
+        qemu_log_mask(LOG_UNIMP, "Unsupported socketcall: %d\n", num);
         return -TARGET_EINVAL;
     }
 }
@@ -4304,7 +4304,8 @@ static abi_long do_ipc(CPUArchState *cpu_env,
         ret = do_shmctl(first, second, ptr);
         break;
     default:
-	gemu_log("Unsupported ipc call: %d (version %d)\n", call, version);
+        qemu_log_mask(LOG_UNIMP, "Unsupported ipc call: %d (version %d)\n",
+                      call, version);
 	ret = -TARGET_ENOSYS;
 	break;
     }
@@ -5152,7 +5153,8 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
     ie = ioctl_entries;
     for(;;) {
         if (ie->target_cmd == 0) {
-            gemu_log("Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
+            qemu_log_mask(
+                LOG_UNIMP, "Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
             return -TARGET_ENOSYS;
         }
         if (ie->target_cmd == cmd)
@@ -5218,8 +5220,9 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
         }
         break;
     default:
-        gemu_log("Unsupported ioctl type: cmd=0x%04lx type=%d\n",
-                 (long)cmd, arg_type[0]);
+        qemu_log_mask(LOG_UNIMP,
+                      "Unsupported ioctl type: cmd=0x%04lx type=%d\n",
+                      (long)cmd, arg_type[0]);
         ret = -TARGET_ENOSYS;
         break;
     }
diff --git a/linux-user/vm86.c b/linux-user/vm86.c
index 2fa7a89edc..4412522c4c 100644
--- a/linux-user/vm86.c
+++ b/linux-user/vm86.c
@@ -402,7 +402,8 @@ int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
     case TARGET_VM86_FREE_IRQ:
     case TARGET_VM86_GET_IRQ_BITS:
     case TARGET_VM86_GET_AND_RESET_IRQ:
-        gemu_log("qemu: unsupported vm86 subfunction (%ld)\n", subfunction);
+        qemu_log_mask(LOG_UNIMP, "qemu: unsupported vm86 subfunction (%ld)\n",
+                      subfunction);
         ret = -TARGET_EINVAL;
         goto out;
     case TARGET_VM86_PLUS_INSTALL_CHECK:
-- 
2.25.0.341.g760bfbb309-goog


