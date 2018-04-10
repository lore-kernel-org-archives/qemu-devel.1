Received: from eggs.gnu.org ([2001:4830:134:3::10]:49436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5oV1-000095-FS
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5oUv-00083w-AI
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:19:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5oUv-00083f-3a
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 04:19:25 -0400
Date: Tue, 10 Apr 2018 09:19:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410081921.GA5155@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA8+gJg4O-ys-KjEVXSEsgd0CZaGXJ=o6nFx4Dv8ccNn0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8+gJg4O-ys-KjEVXSEsgd0CZaGXJ=o6nFx4Dv8ccNn0A@mail.gmail.com>
Subject: Re: [Qemu-devel] qom-test on netbsd can be very slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Apr 09, 2018 at 06:10:43PM +0100, Peter Maydell wrote:
> My NetBSD build system recently seems to have taken a nosedive
> in how long it takes to finish "make check". This seems to be
> because qom-test (and probably other things where the test interacts
> with the QEMU process) can run very slowly.
> 
> netbsdvm# for i in 1 2 3 4 5 6 7 8 9 10; do
> (QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 time
> tests/qom-test -p /x86_64/qom/pc-i440fx-2.0); done
> /x86_64/qom/pc-i440fx-2.0: OK
>         8.49 real         1.18 user         7.34 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        10.41 real         1.32 user         9.09 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         8.45 real         1.24 user         7.24 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         9.88 real         1.10 user         8.31 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        11.60 real         1.47 user         9.90 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        10.94 real         1.28 user         9.68 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        10.06 real         1.32 user         8.76 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        13.38 real         1.37 user        12.04 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        16.19 real         1.46 user        14.29 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         9.70 real         1.17 user         8.51 sys
> 
> Admittedly this is running in a (KVM) VM, but still, there seems
> something wrong with how long each of these is taking. On Linux
> each run is less than a second, so there's an order-of-magnitude
> slowdown here. Further, I've occasionally seen a run take 100 seconds!
> 
> Does anybody else see this, and any ideas why it might be running slow?

My only real suggestion is to try "git bisect" as presumably this is
a regression caused by something we've merged in this dev cycle ?

> One thing I noticed looking at ktrace output is that we do
> all our reading of QMP input and output with a read syscall
> per character. I don't think that's the cause of this slowness,
> though.

IIRC, that has been long standing behaviour so would be unlikely to
explain a recent slowdown, nor the huge variation in time for some
runs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
