Received: from eggs.gnu.org ([2001:4830:134:3::10]:48945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZuwn-0005lT-0j
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZuwj-0000ky-1m
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:12:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZuwi-0000kY-Ql
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:12:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170724150805.19563-1-dgilbert@redhat.com>
Date: Tue, 25 Jul 2017 10:11:48 +0200
In-Reply-To: <20170724150805.19563-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 24 Jul 2017 16:08:05 +0100")
Message-ID: <87y3rdvsu3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] hmp/(p)memsave: Allow >32bit file size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, admin@manateeshome.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> memsave and pmemsave only take 32bit size arguments in HMP at the
> moment; let them take 64bit values.
>
> Reported-by: Pierre Kim <admin@manateeshome.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hmp-commands.hx |  4 ++--
>  hmp.c           | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 1941e19932..ddf77ae7ac 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -829,7 +829,7 @@ ETEXI
>  
>      {
>          .name       = "memsave",
> -        .args_type  = "val:l,size:i,filename:s",
> +        .args_type  = "val:l,size:l,filename:s",
>          .params     = "addr size file",
>          .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
>          .cmd        = hmp_memsave,

The size is wider, but still signed.  Reproduces QAPI/QMP's mistake.  We
should fix it there, and make this "size:o" here, so suffixes work as
they should.

I'll cook up a QAPI/QMP patch.

[...]
