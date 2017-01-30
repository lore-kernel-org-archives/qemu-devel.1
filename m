Received: from eggs.gnu.org ([2001:4830:134:3::10]:53892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cYD9p-0001a7-3X
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cYD9j-00011Q-UE
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:42:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cYD9j-00011H-OF
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:42:07 -0500
References: <20170130131517.8092-1-sw@weilnetz.de>
From: David Hildenbrand <david@redhat.com>
Message-ID: <37b4af98-1658-8dff-0d1f-554d8d1c64d9@redhat.com>
Date: Mon, 30 Jan 2017 15:42:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170130131517.8092-1-sw@weilnetz.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>

Am 30.01.2017 um 14:15 schrieb Stefan Weil:
> Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> v2: Re-sent as v1 was damaged by my mailer.
> 

Just tested your patch:

Reviewed-by: David Hildenbrand <david@redhat.com>

> This is also broken in Debian.
> 
> In addition, there is no default CPU ("any"), so binfmt and related
> actions currently don't work. I hacked my local installation by
> duplicating the "qemu" cpu definition for "any", but maybe there is
> a better solution.
> 

This should do the trick, will send it as an official patch:

>From e7109d1c235e463c12feeaf5d3f1d6763f34be85 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 30 Jan 2017 15:33:05 +0100
Subject: [PATCH] target/s390x: "qemu" is the name od the default model

"any" does not exist, therefore resulting in a misleading error message.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 linux-user/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 3004958..e588f58 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4322,6 +4322,8 @@ int main(int argc, char **argv, char **envp)
 # endif
 #elif defined TARGET_SH4
         cpu_model = TYPE_SH7785_CPU;
+#elif defined TARGET_S390X
+        cpu_model = "qemu";
 #else
         cpu_model = "any";
 #endif
-- 
2.9.3

-- 

David
