Received: from eggs.gnu.org ([2001:4830:134:3::10]:60033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fJ0M5-0003Xn-39
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fJ0M1-0004Df-V9
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:36:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fJ0M1-0004Cs-Km
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:36:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4GHYqvb129261
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 13:36:42 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j0pny7hdm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 13:36:42 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Wed, 16 May 2018 13:36:41 -0400
Date: Wed, 16 May 2018 14:36:32 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-4-alex.bennee@linaro.org>
	<bb44b0dc-d0c2-2ff3-1815-00b80f199848@linux.ibm.com>
	<87r2mbeihr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87r2mbeihr.fsf@linaro.org>
Message-Id: <20180516173632.GC15866@kermit-br-ibm-com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/46] configure: add support for
 --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, famz@redhat.com, qemu-devel@nongnu.org, richard.henderson@linaro.org, f4bug@amsat.org, agraf@suse.de, cota@braap.org, aurelien@aurel32.net

On Wed, May 16, 2018 at 04:18:56PM +0100, Alex Benn=E9e wrote:
>=20
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
>=20
> > On 04/24/2018 12:23 PM, Alex Benn=E9e wrote:
> >> This allows us to specify cross compilers for our guests. This is
> >> useful for building test images/programs. Currently we re-run the
> >> compile test for each target. I couldn't think of a way to cache the
> >> value for a given arch without getting messier configure code.
> >>
> >> The cross compiler for the guest is visible to each target as
> >> CROSS_CC_GUEST in config-target.mak.
> >>
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >>
> >> ---
> >> v3
> >>   - --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit...
> >>   - --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%=
%=3D*}
> >>   - add remaining target_compiler definitions
> >> ---
> >>  configure | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
> >>  1 file changed, 79 insertions(+)
> >>
> >> diff --git a/configure b/configure
> >> index b0ae632ee4..caa838a0d0 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -453,6 +453,13 @@ vxhs=3D""
> >>  libxml2=3D""
> >>  docker=3D"no"
> >>
> >> +# cross compilers defaults, can be overridden with --cross-cc-ARCH
> >> +cross_cc_aarch64=3D"aarch64-linux-gnu-gcc"
> >> +cross_cc_arm=3D"arm-linux-gnueabihf-gcc"
> >> +cross_cc_powerpc=3D"powerpc-linux-gnu-gcc"
> >
> > Do we need to have default values for all targets?
> >
> >> +
> >> +enabled_cross_compilers=3D""
> >> +
> >>  supported_cpu=3D"no"
> >>  supported_os=3D"no"
> >>  bogus_os=3D"no"
> >> @@ -483,6 +490,11 @@ for opt do
> >>    ;;
> >>    --disable-debug-info) debug_info=3D"no"
> >>    ;;
> >> +  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-c=
c-FOO option"
> >> +  ;;
> >> +  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=
=3D*}
> >> +                eval "cross_cc_${cc_arch}=3D\$optarg"
> >> +  ;;
> >
> > Do we need to verify if a valid --cross-cc-FOO was passed, in case of=
 a
> > typo?
>=20
> How so? We do attempt to build with these options later.

Hi, Alex.

User can mistakenly pass, for example, --cross-cc-ppc64el=3D instead of t=
he
expected --cross-cc-ppc64le=3D. I was wondering if we need to validate th=
is kind
of input (inexistent $cross_cc_* variable) and consider --cross-cc-ppc64e=
l=3D an
invalid option, in this example.

By the way, are you updating the --help text explaining these new --cross=
-cc-*
options?

--=20
Murilo
