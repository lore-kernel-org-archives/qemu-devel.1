Received: from eggs.gnu.org ([2001:4830:134:3::10]:49349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJ3BD-0000gx-F1
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJ3B9-00016N-HA
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:37:47 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJ3B9-000161-A1
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:37:43 -0400
Received: by mail-wr0-x242.google.com with SMTP id v15-v6so3253376wrm.10
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 13:37:43 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-4-alex.bennee@linaro.org>
	<bb44b0dc-d0c2-2ff3-1815-00b80f199848@linux.ibm.com>
	<87r2mbeihr.fsf@linaro.org>
	<20180516173632.GC15866@kermit-br-ibm-com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180516173632.GC15866@kermit-br-ibm-com>
Date: Wed, 16 May 2018 21:37:40 +0100
Message-ID: <87po1ve3qj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: peter.maydell@linaro.org, famz@redhat.com, qemu-devel@nongnu.org, richard.henderson@linaro.org, f4bug@amsat.org, agraf@suse.de, cota@braap.org, aurelien@aurel32.net


Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:

> On Wed, May 16, 2018 at 04:18:56PM +0100, Alex Benn=C3=A9e wrote:
>>
>> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
>>
>> > On 04/24/2018 12:23 PM, Alex Benn=C3=A9e wrote:
>> >> This allows us to specify cross compilers for our guests. This is
>> >> useful for building test images/programs. Currently we re-run the
>> >> compile test for each target. I couldn't think of a way to cache the
>> >> value for a given arch without getting messier configure code.
>> >>
>> >> The cross compiler for the guest is visible to each target as
>> >> CROSS_CC_GUEST in config-target.mak.
>> >>
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >>
>> >> ---
>> >> v3
>> >>   - --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit...
>> >>   - --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=
=3D*}
>> >>   - add remaining target_compiler definitions
>> >> ---
>> >>  configure | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>> >>  1 file changed, 79 insertions(+)
>> >>
>> >> diff --git a/configure b/configure
>> >> index b0ae632ee4..caa838a0d0 100755
>> >> --- a/configure
>> >> +++ b/configure
>> >> @@ -453,6 +453,13 @@ vxhs=3D""
>> >>  libxml2=3D""
>> >>  docker=3D"no"
>> >>
>> >> +# cross compilers defaults, can be overridden with --cross-cc-ARCH
>> >> +cross_cc_aarch64=3D"aarch64-linux-gnu-gcc"
>> >> +cross_cc_arm=3D"arm-linux-gnueabihf-gcc"
>> >> +cross_cc_powerpc=3D"powerpc-linux-gnu-gcc"
>> >
>> > Do we need to have default values for all targets?
>> >
>> >> +
>> >> +enabled_cross_compilers=3D""
>> >> +
>> >>  supported_cpu=3D"no"
>> >>  supported_os=3D"no"
>> >>  bogus_os=3D"no"
>> >> @@ -483,6 +490,11 @@ for opt do
>> >>    ;;
>> >>    --disable-debug-info) debug_info=3D"no"
>> >>    ;;
>> >> +  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc=
-FOO option"
>> >> +  ;;
>> >> +  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=
=3D*}
>> >> +                eval "cross_cc_${cc_arch}=3D\$optarg"
>> >> +  ;;
>> >
>> > Do we need to verify if a valid --cross-cc-FOO was passed, in case of a
>> > typo?
>>
>> How so? We do attempt to build with these options later.
>
> Hi, Alex.
>
> User can mistakenly pass, for example, --cross-cc-ppc64el=3D instead of t=
he
> expected --cross-cc-ppc64le=3D. I was wondering if we need to validate th=
is kind
> of input (inexistent $cross_cc_* variable) and consider --cross-cc-ppc64e=
l=3D an
> invalid option, in this example.

OK I understand. I'm not sure how to do this without having a whole bunch of
additional boilerplate code though. I guess there is likely to be churn
each time a new guest architecture is added though.

We do currently dump the list of enabled compilers at the end of
configure so that at least should give the user some indication of what
didn't work?

> By the way, are you updating the --help text explaining these new --cross=
-cc-*
> options?

Yes.

--
Alex Benn=C3=A9e
