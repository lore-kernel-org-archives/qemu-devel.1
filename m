Received: from eggs.gnu.org ([2001:4830:134:3::10]:52035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emFFR-0007E4-E8
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 03:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emFFM-00049o-Iv
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 03:50:33 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emFFM-000492-7p
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 03:50:28 -0500
References: <faca1d54-8c99-cece-b427-b994307516dd@bitmessage.ch>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3fbe94a4-a378-b0ee-b504-fad5d3de630c@vivier.eu>
Date: Thu, 15 Feb 2018 09:50:20 +0100
MIME-Version: 1.0
In-Reply-To: <faca1d54-8c99-cece-b427-b994307516dd@bitmessage.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] syscall: fix special case of write(fd, NULL,
 0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Oliver Smith <ollieparanoid@bitmessage.ch>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: zhuoweizhang@yahoo.com

Le 15/02/2018 à 00:33, Oliver Smith a écrit :
> Hello there,
> 
> I'm a little late to the party. But what is necessary to get this
> upstreamed, and how can I help?
> 
> PS: Sorry if I picked the wrong e-mail addresses, I wasn't subscribed to
> the ML at that point and used the addresses I could find for the people
> who answered to the original thread here:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg08073.html

According to comments in the ML thread, you need to:

- update the patch to call write() with NULL and 0, something like:

--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7912,6 +7912,10 @@ abi_long do_syscall(void *cpu_env, int num,
abi_long arg1,
         }
         break;
     case TARGET_NR_write:
+        if (arg2 == 0 && arg3 == 0) {
+            ret = get_errno(safe_write(arg1, NULL, 0));
+            break;
+        }
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
             goto efault;
         if (fd_trans_target_to_host_data(arg1)) {

- change TARGET_NR_read to do the same

- check if we need to do the same for pread64/pwrite64

Thanks,
Laurent
