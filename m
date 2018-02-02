Received: from eggs.gnu.org ([208.118.235.92]:38489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eheSS-0005qZ-VQ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eheSN-0000sb-S5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:45:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eheSN-0000rK-Bb
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:44:55 -0500
Date: Fri, 2 Feb 2018 16:44:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180202164446.GP15403@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 00/21] Modularize generated QAPI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On Fri, Feb 02, 2018 at 02:03:15PM +0100, Markus Armbruster wrote:
> Our qapi-schema.json is composed of modules connected by include
> directives, but the generated code is monolithic all the same: one
> qapi-types.h with all the types, one qapi-visit.h with all the
> visitors, and so forth.  These monolithic headers get included all
> over the place.  In my "build everyhing" tree, adding a QAPI type
> recompiles about 4500 out of 4800 objects.
> 
> Nobody would write such monolithic headers by hand.  It stands to
> reason that one shouldn't generate them, either.
> 
> This series' basic idea is to split up generated headers to mirror the
> schema's modular structure: one header per module.  That way, you can
> include just what you need.
> 
> The series is RFC for a number of reasons:
> 
> * The split is implemented only for qapi-types.h.  That one should
>   provide the biggest benefits, though.
> 
> * There's a bit of code duplication.
> 
> * I haven't re-read my patches, yet.
> 
> Even in this incomplete state, the compile-time improvements can be
> massive.  Before this series, any QAPI schema change recompiles some
> 4500 out of 4800 objects in my "build everything" tree.  Afterwards,
> adding a type to qapi/migration.json recompiles less than 400, adding
> a QMP event recompiles less than 200, and a documentation change no
> longer recompiles anything.

Having gone through the same exercise for trace.h, I very much welcome
this effort for QAPI too !

If I consider the crypto stuff I maintain, the QAPI definitions are
in qapi/crypto.json.

>From my POV, I feel it would be natural to have them move to instead
be at  crypto/qapi.json, and have the generated headers/source files be
crypto/qapi-types.h, crypto/qapi-visit.h, etc.

This would mirror what we did with tracing, crypto/trace-events, and
generating crypto/trace*.{c,h}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
