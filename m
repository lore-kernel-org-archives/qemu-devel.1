Received: from eggs.gnu.org ([2001:4830:134:3::10]:60701)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1e4QN2-0007wm-G3
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1e4QMx-0008KP-KA
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:49:16 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:33094 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1e4QMx-0008JL-B1
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:49:11 -0400
References: <8e2160db-338f-f1dc-7f5e-8faa3dce7090@kamp.de>
	<20171017114625.GB7660@dhcp-200-186.str.redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <02ff8cd2-3061-ca10-8235-c2295de58562@kamp.de>
Date: Tue, 17 Oct 2017 13:49:08 +0200
MIME-Version: 1.0
In-Reply-To: <20171017114625.GB7660@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] Clean Block Driver Shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, armbru@redhat.com

Am 17.10.2017 um 13:46 schrieb Kevin Wolf:
> Am 17.10.2017 um 12:33 hat Peter Lieven geschrieben:
>> I noticed that Qemu quits at several points with an exit() if the
>> supplied parameters in the commandline are incorrect. This at some
>> stages happens after there have already been connections to storage
>> backends established.
> Maybe we need to come to the conclusion that exit() is always wrong,
> even during the initialisation.
>
>> These connections are not cleanly shut down in this case. For posix
>> file backends that doesn't matter, but for other backends this leads
>> to errors. E.g. iSCSI Targets log an aborted iSCSI connection due to
>> tcp reset.
>>
>> I wonder what is the best way to fix this. A simply call to
>> bdrv_close_all() in an atexit handler seems to work.  But is this a
>> good solution? Maybe register this handler only until the VM starts.
>> Or do we need an atexit handler in each block driver that requires a
>> clean shutdown?
> No, definitely not code in every single block driver. We need to make
> sure to properly clean up what has been started.
>
> An atexit handler is probably relatively easy. I think it would be
> cleaner to have proper error paths even in main(), like in every other
> function. I'm not sure if this would be reasonably easy to achieve,
> though.

A clean error path would obviously be a good idea. However,
the following seems to work:

diff --git a/vl.c b/vl.c
index 0723835..bed512c 100644
--- a/vl.c
+++ b/vl.c
@@ -3197,6 +3197,7 @@ int main(int argc, char **argv, char **envp)
      nb_nics = 0;

      bdrv_init_with_whitelist();
+    atexit(bdrv_close_all);

      autostart = 1;

Peter
