Received: from eggs.gnu.org ([209.51.188.92]:51159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyH0t-0000r7-5K
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyH0s-0004B6-C0
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:13:47 -0500
References: <201902230335.59138.randrianasulu@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73674f1b-db17-6913-d21d-a96c7da313c6@redhat.com>
Date: Mon, 25 Feb 2019 08:13:35 -0600
MIME-Version: 1.0
In-Reply-To: <201902230335.59138.randrianasulu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Build error with git commit
 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 on x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Adding people in cc based on 'scripts/get-maintainer.pl -f
qobject/block-qdict.c'

On 2/22/19 6:35 PM, Andrew Randrianasulu wrote:
> Hello!
> 
> I just pulled latest git
> 
> up to 
> commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 (HEAD -> master, origin/master, 
> origin/HEAD)
> Merge: a05838cb2a 2b6326c0bf
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Fri Feb 22 15:48:04 2019 +0000

> and default build with simple ./configure on slackware 14.2 x86-64 box failed 
> like this:
> 

> qobject/block-qdict.c: In function 'qdict_array_split':
> qobject/block-qdict.c:259:9: error: 'subqdict' may be used uninitialized in this 
> function [-Werror=maybe-uninitialized]
>          qlist_append_obj(*dst, subqobj ?: QOBJECT(subqdict));
>          ^

Appears to be a false positive, but one that the compiler can't see
through (that is, subqdict is only used if subqobj is NULL, but proving
that all code paths either set subqobj or subqdict is not trivial for
the compiler).  I suspect this would fix it.

diff --git i/qobject/block-qdict.c w/qobject/block-qdict.c
index 1487cc5dd8b..b26524429c0 100644
--- i/qobject/block-qdict.c
+++ w/qobject/block-qdict.c
@@ -224,7 +224,7 @@ void qdict_array_split(QDict *src, QList **dst)
     for (i = 0; i < UINT_MAX; i++) {
         QObject *subqobj;
         bool is_subqdict;
-        QDict *subqdict;
+        QDict *subqdict = NULL;
         char indexstr[32], prefix[32];
         size_t snprintf_ret;

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
