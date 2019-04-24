Received: from eggs.gnu.org ([209.51.188.92]:58256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJGMA-00039I-Kn
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJG7J-0007oT-M5
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:31:11 -0400
Date: Wed, 24 Apr 2019 12:25:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190424112537.GF31388@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424103747.10173-3-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] tests/qemu-iotests/group: Introduce a
 new "ci" group for CI pipelines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

On Wed, Apr 24, 2019 at 12:37:43PM +0200, Thomas Huth wrote:
> Tests in this group are supposed to run in every possible QEMU configuration.
> That means they should run with every QEMU binary (also non-x86), without
> dependencies on an optional features, they must work at least with the qcow2
> image format and be able to run on all kind of host filesystems and users
> (i.e. also as "nobody" or "root").
> 
> The initial list has been created as a subset of the "quick" group, where
> I've disabled all tests that are failing with qemu-system-aarch64 or
> qemu-system-tricore or in one of our CI pipelines.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/group | 194 ++++++++++++++++++++-------------------
>  1 file changed, 102 insertions(+), 92 deletions(-)
> 
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index bae7718380..2ed42dcc14 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -4,63 +4,73 @@
>  # - do not start group names with a digit
>  #
>  
> +#
> +# Some notes about the groups:
> +# - Tests in the "quick" group should finish within some few seconds
> +# - Tests in the "ci" group are suitable for running in CI systems. That
> +#   means they should run with every QEMU binary (also non-x86), with
> +#   every QEMU configuration (i.e. no dependency on an optional feature),
> +#   at least with the qcow2 image format and all kind of host filesystems
> +#   and users (i.e. also as "nobody" or "root").

No dependancy on optional features feels a bit restrictive from my POV.

We have quite alot of testing coverage of stuff that depends on the
crypto libraries that is important for us to run in "CI". This includes
LUKS block drivers, qcow2 with LUKS,  NBD with TLS. Personally I expect
all of those to be tested by CI systems.

IOW for a "CI" group, the bar should be higher than "no optional features"

Since we control the env used for CI via Docker or VM images, we can ensure
that they're populated with a set of packages that maximises our coverage.
All our platforms support gnutls for example, which gets us all the crypto
bits we need.

The problem of course is the desire to put this into "make check" by default
which developers can run in any configuration.

I think this is a sign that we need two distinct groupings.

Stuff run by a generic "make check" /should not/ depend on optional features,

Stuff run by an automated CI system /should/ depend on optional features. 

IOW, we should have:

   * "ci-min" - no deps on optional things configure might disable
   * "ci-max" - as many features as possible (assume Docker & VM
                images include them)

"make check" would default to "ci-min", but our CI systems can set
SPEED=thorough, causing "make check" to use "ci-max" instead ?

> -001 rw auto quick
> -002 rw auto quick
> +001 rw auto quick ci
> +002 rw auto quick ci
>  003 rw auto
> -004 rw auto quick
> -005 img auto quick
> +004 rw auto quick ci
> +005 img auto quick ci

Does anyone call what the "auto" group is supposed to be for ?

Its name kind of suggests it was for automated CI but maybe I'm reading
too much in to that ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
