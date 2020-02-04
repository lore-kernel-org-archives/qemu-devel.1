Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA87C33CAC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F108920732
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wO6OYppp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F108920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyoNG-0003lZ-5G
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 21:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60819)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <37Nw4XgMKCoEop4lttlqj.htrvjrz-ij0jqstslsz.twl@flex--jkz.bounces.google.com>)
 id 1iyoMJ-0002XR-Nu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <37Nw4XgMKCoEop4lttlqj.htrvjrz-ij0jqstslsz.twl@flex--jkz.bounces.google.com>)
 id 1iyoMH-0002wO-Se
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:39 -0500
Received: from mail-ua1-x94a.google.com ([2607:f8b0:4864:20::94a]:37727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <37Nw4XgMKCoEop4lttlqj.htrvjrz-ij0jqstslsz.twl@flex--jkz.bounces.google.com>)
 id 1iyoMH-0002sL-Mh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:37 -0500
Received: by mail-ua1-x94a.google.com with SMTP id f15so4464831uap.4
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 18:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=jDLy4y7g4nLW8NWtQ8mTh8+T+7gif7mRZiEY+32+ELk=;
 b=wO6OYppp7p3UsLaSWZCkb7Qg+ZfC8+Ilq1MWmxScGDdq1FSddn4KY6mFM0hfgt+px9
 MIf9NeGSsDqs7a14GrlOX9zD6SNVSML6+rfGQ4ux+PwGA9cD7XEXU0a3SttqBdH4jIW1
 XKtJPAltHqgyO2bgrHB3xMYTb2Yjm013/yEfZeuqMgod791PNagzcp/sW0T8BCwPpMD6
 49MnHYsjLKpJknmLDCZ1UBMzloqI7FNfaWqXTlsRnp9OBYSR79RwnNrwFvIpCj16kuw1
 QHhADDdsXzMsecZ8PYRg7vYAR64dePcVDCympTJ5RcbHvRrXgqtvgAgQ95PqhObWzgr8
 apKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jDLy4y7g4nLW8NWtQ8mTh8+T+7gif7mRZiEY+32+ELk=;
 b=oZGkzMLEJNB8+o8WkNeTFhVjBpIl7DIxsmmWpzjVkwyH2Cu5d550blxQnX4k9XSFRJ
 Kq+So0Qri+E1qY75zjlE2Wv+e7nAIkN44neC5Vant0XbKZwm5CtbTtY0xgSMTWM82yb8
 TqgMjtj4mJ6HuoCubB6ARNsofOZ95czI+a1htyjibZRy56Y24P/gOg+RNnakHnwh8a87
 5x04zKeCGfuhSbmuxWmiD224ke9meBQZk6PyrThQ6FW9Rt7qWg8H21AoKR77u7DPfrDj
 1i2JMeecQA24DLIT4EYbYjrlRAFGFjpI+Ji+DojcpWNPZNwlyRmLdSv6bZ/PrN/voQkr
 Odxw==
X-Gm-Message-State: APjAAAVeO4qp3czcn8jOnEIYnh0eB35h27CMsqtjPop+cLSrD+PHyyOY
 Tz0y7ANCAVu79GU/gvT9mgF7SBJEcrjISe0jvaj55DHxVM+ZSMiZTvjT/0V3g3idPehvIO2GSwi
 bLvznYvUkjdK22gMq9yRn+fH9m9Jycvp24/uVLx/+bdpZepE8si6m
X-Google-Smtp-Source: APXvYqxTeqxVQwWrQr1YP/iVGIcESZIpo1do2pB1r7hmVJ31j7DLKLseHUnbEuKb/Zo1gHg1q43Mqn0=
X-Received: by 2002:ab0:6001:: with SMTP id j1mr16079873ual.56.1580784876611; 
 Mon, 03 Feb 2020 18:54:36 -0800 (PST)
Date: Mon,  3 Feb 2020 18:54:13 -0800
In-Reply-To: <20200204025416.111409-1-jkz@google.com>
Message-Id: <20200204025416.111409-2-jkz@google.com>
Mime-Version: 1.0
References: <20200204025416.111409-1-jkz@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 1/4] linux-user: Use `qemu_log' for non-strace logging
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, imp@bsdimp.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::94a
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
 linux-user/syscall.c      | 35 ++++++++++++++++---------
 linux-user/vm86.c         |  3 ++-
 4 files changed, 62 insertions(+), 36 deletions(-)

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
index d60142f069..c48c2a9a55 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1560,7 +1560,11 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
              * something more intelligent than "twice the size of the
              * target buffer we're reading from".
              */
-            gemu_log("Host cmsg overflow\n");
+            qemu_log_mask(LOG_UNIMP,
+                          ("Unsupported ancillary data %d/%d: "
+                           "unhandled msg size\n"),
+                          tswap32(target_cmsg->cmsg_level),
+                          tswap32(target_cmsg->cmsg_type));
             break;
         }
 
@@ -1590,8 +1594,8 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
             __get_user(cred->uid, &target_cred->uid);
             __get_user(cred->gid, &target_cred->gid);
         } else {
-            gemu_log("Unsupported ancillary data: %d/%d\n",
-                                        cmsg->cmsg_level, cmsg->cmsg_type);
+            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+                          cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(data, target_data, len);
         }
 
@@ -1812,8 +1816,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
 
         default:
         unimplemented:
-            gemu_log("Unsupported ancillary data: %d/%d\n",
-                                        cmsg->cmsg_level, cmsg->cmsg_type);
+            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+                          cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(target_data, data, MIN(len, tgt_len));
             if (tgt_len > len) {
                 memset(target_data + len, 0, tgt_len - len);
@@ -2288,7 +2292,8 @@ set_timeout:
 #endif /* SOL_NETLINK */
     default:
     unimplemented:
-        gemu_log("Unsupported setsockopt level=%d optname=%d\n", level, optname);
+        qemu_log_mask(LOG_UNIMP, "Unsupported setsockopt level=%d optname=%d\n",
+                      level, optname);
         ret = -TARGET_ENOPROTOOPT;
     }
     return ret;
@@ -2641,8 +2646,9 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
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
@@ -3397,7 +3403,7 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
     case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
         return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 1);
     default:
-        gemu_log("Unsupported socketcall: %d\n", num);
+        qemu_log_mask(LOG_UNIMP, "Unsupported socketcall: %d\n", num);
         return -TARGET_EINVAL;
     }
 }
@@ -4308,7 +4314,8 @@ static abi_long do_ipc(CPUArchState *cpu_env,
         ret = do_shmctl(first, second, ptr);
         break;
     default:
-	gemu_log("Unsupported ipc call: %d (version %d)\n", call, version);
+        qemu_log_mask(LOG_UNIMP, "Unsupported ipc call: %d (version %d)\n",
+                      call, version);
 	ret = -TARGET_ENOSYS;
 	break;
     }
@@ -5156,7 +5163,8 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
     ie = ioctl_entries;
     for(;;) {
         if (ie->target_cmd == 0) {
-            gemu_log("Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
+            qemu_log_mask(
+                LOG_UNIMP, "Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
             return -TARGET_ENOSYS;
         }
         if (ie->target_cmd == cmd)
@@ -5224,8 +5232,9 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
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


