Received: from eggs.gnu.org ([2001:4830:134:3::10]:51883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fYqK9-00011m-TJ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fYqK5-0004Bx-Sb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:08:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1fYqK5-00049p-MX
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:08:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A73A401CE88
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 10:08:12 +0000 (UTC)
Date: Fri, 29 Jun 2018 12:08:08 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180629100808.GC24405@paraplu>
References: <20180625101216.GE18277@paraplu>
	<87y3ez150t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3ez150t.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] RNG: Any reason QEMU doesn't default to
 `/dev/urandom`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, dgilbert@redhat.com, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>

On Thu, Jun 28, 2018 at 02:15:14PM +0200, Markus Armbruster wrote:
> Kashyap Chamarthy <kchamart@redhat.com> writes:

[...]

> There's also getrandom(2).
> 
> See random(7) for a comparison between getrandom(), /dev/urandom,
> /dev/random.
> 
> As you wrote, Linux's /dev/random blocks when the kernel entropy pool
> has been depleted, while /dev/urandom doesn't.  There are systems where
> both devices behave exactly the same, or only /dev/random exists.
> Trying /dev/urandom first, and /dev/random as fallback is simple and
> works okay across a wide range of hosts.  That said, getrandom(2) or
> getentropy(3) are even nicer when available.
> 
> I can see two uses of /dev/random in QEMU outside tests:
> 
> * crypto/random-platform.c
> 
>     int qcrypto_random_init(Error **errp)
>     {
>     #ifndef _WIN32
>         /* TBD perhaps also add support for BSD getentropy / Linux
>          * getrandom syscalls directly */
>         fd = open("/dev/urandom", O_RDONLY);
>         if (fd == -1 && errno == ENOENT) {
>             fd = open("/dev/random", O_RDONLY);
>         }
> 
>         if (fd < 0) {
>             error_setg(errp, "No /dev/urandom or /dev/random found");
>             return -1;
>         }
>     #else
>     [...]
>     #endif
> 
>         return 0;
>     }
> 
>   Looks good to me.  Resolving the TBD would be nice.
> 
> * backends/rng-random.c
> 
>     static void rng_random_init(Object *obj)
>     {
>         RngRandom *s = RNG_RANDOM(obj);
> 
>         object_property_add_str(obj, "filename",
>                                 rng_random_get_filename,
>                                 rng_random_set_filename,
>                                 NULL);
> 
>         s->filename = g_strdup("/dev/random");
>         s->fd = -1;
>     }
> 
>    This is TYPE_RNG_RANDOM's instance_init() method.  Doesn't look so
>    good, but it's "only" a default.
> 
>    What TYPE_RNG_RANDOM's intended use?  The manual suggests "backend
>    for virtio-rng":
> 
>     @item -object rng-random,id=@var{id},filename=@var{/dev/random}
> 
>     Creates a random number generator backend which obtains entropy from
>     a device on the host. The @option{id} parameter is a unique ID that
>     will be used to reference this entropy backend from the @option{virtio-rng}
>     device. The @option{filename} parameter specifies which file to obtain
>     entropy from and if omitted defaults to @option{/dev/random}.
> 
> Regardless of other considerations, duplicating something as hairy as
> getting high-quality random numbers from the host in a portable manner
> is a Bad Idea.

I see, thanks for the detailed responses, both.  This is not really a
high-priority item for management layers for now.  For now, (OpenStack)
Nova overrides the QEMU default.

-- 
/kashyap
