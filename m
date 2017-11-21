Received: from eggs.gnu.org ([2001:4830:134:3::10]:60527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH7Jz-0002LV-Hd
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH7Ju-0000m4-Jb
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:06:35 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:44470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eH7Ju-0000lC-BA
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:06:30 -0500
Received: by mail-wr0-x22a.google.com with SMTP id l22so11059256wrc.11
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 04:06:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171031145444.13766-7-alex.bennee@linaro.org>
References: <20171031145444.13766-1-alex.bennee@linaro.org>
	<20171031145444.13766-7-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 12:06:08 +0000
Message-ID: <CAFEAcA8X-Nv7i5EOMR=WvAtjXfuSyoQCd6ntCY7T99t4J6H45A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 6/7] risugen: support @GroupName in
 risu files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 31 October 2017 at 14:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> The existing pattern support is useful but it does get a little
> tedious when faced with large groups of instructions. This introduces
> the concept of a @GroupName which can be sprinkled in the risu
> definition and is attached to all instructions following its
> definition until the next group or an empty group "@" is specified.
>
> It can be combined with the existing pattern support to do things
> like:
>
>   ./risugen --group AdvSIMDAcrossVector --not-pattern ".*_RES" aarch64.ri=
su foo.bin
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


I think the general idea here is fine but some extra checking
of syntax in the implementation would be good.


> ---
>  README  | 10 ++++++++++
>  risugen | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/README b/README
> index 312e9cd..9946e6e 100644
> --- a/README
> +++ b/README
> @@ -75,6 +75,10 @@ reads the configuration file arm.risu, and generates 1=
0000 instructions
>  based on the instruction patterns matching the regular expression
>  "VQSHL.*imm.*". The resulting binary is written to vqshlimm.out.
>
> +An alternative to using regular expression patterns is to use the
> +--group specifier. This relies on the configuration file having been
> +annotated with suitable @ markers.

If I say "--group foo --group bar" am I asking for insns which
are in both group foo and bar, or insns which are in either
foo or bar or both ?

> +
>  This binary can then be passed to the risu program, which is
>  written in C. You need to run risu on both an ARM native target
>  and on the program under test. The ARM native system is the 'master'
> @@ -140,6 +144,12 @@ Lines starting with a '.' are directives to risu/ris=
ugen:
>   * ".mode [thumb|arm]" specifies whether the file contains ARM
>     or Thumb instructions; it must precede all instruction patterns.
>
> +Lines starting with a '@' are a grouping directive. Instructions
> +following will be assigned to a comma separated list of groups. The
> +list of groups is reset at the next '@' directive which may be empty.
> +This provides an alternative method to selecting instructions than RE
> +patterns.
> +
>  Other lines are instruction patterns:
>   insnname encodingname bitfield ... [ [ !blockname ] { blocktext } ]
>  where each bitfield is either:
> diff --git a/risugen b/risugen
> index 8bfb0e9..aba4bb7 100755

> --- a/risugen
> +++ b/risugen
> @@ -34,7 +34,10 @@ my @insn_keys;
>
>  # The arch will be selected based on .mode directive defined in risu fil=
e.
>  my $arch =3D "";
> +# Current group, updated by @GroupName
> +my $insn_group =3D "";
>
> +my @group =3D ();                 # include groups
>  my @pattern_re =3D ();            # include pattern
>  my @not_pattern_re =3D ();        # exclude pattern
>
> @@ -122,6 +125,11 @@ sub parse_config_file($)
>              exit(1);
>          }
>
> +        if ($tokens[0] =3D~ /^@(.*)/ ) {
> +            $insn_group =3D $1;
> +            next;
> +        }

Here, the syntax we're parsing is supposed to be @ followed
by a comma-separated list of groupnames, right? But we treat
everything after the '@ as a single opaque string.
I think we should properly parse this, allowing whitespace
before/after commas, maybe restrict the set of characters
we allow in groupnames, and store them as an array of group
names rather than a raw string.

> +
>          if ($tokens[0] =3D~ /^\./) {
>              parse_risu_directive($file, $seen_pattern, @tokens);
>              next;
> @@ -239,6 +247,9 @@ sub parse_config_file($)
>          $insnrec->{fixedbits} =3D $fixedbits;
>          $insnrec->{fixedbitmask} =3D $fixedbitmask;
>          $insnrec->{fields} =3D [ @fields ];
> +        if (length $insn_group) {
> +            $insnrec->{group} =3D $insn_group;
> +        }
>          $insn_details{$insnname} =3D $insnrec;
>      }
>      close(CFILE) or die "can't close $file: $!";
> @@ -249,6 +260,12 @@ sub select_insn_keys ()
>  {
>      # Get a list of the insn keys which are permitted by the re patterns
>      @insn_keys =3D sort keys %insn_details;
> +    if (@group) {
> +        my $re =3D join("|",@group);
> +        @insn_keys =3D grep {
> +            defined($insn_details{$_}->{group}) &&
> +                grep /$re/, $insn_details{$_}->{group}} @insn_keys

This implementation is implicitly permitting regex characters in
the user-specified --group argument. Is that intentional?
If we store the group names for the insn as an array of names
then we can just check for an explicit match in them against
the user's provided set of names.

> +    }
>      if (@pattern_re) {
>          my $re =3D '\b((' . join(')|(',@pattern_re) . '))\b';
>          @insn_keys =3D grep /$re/, @insn_keys;
> @@ -277,6 +294,7 @@ Valid options:
>      --fpscr n    : set initial FPSCR (arm) or FPCR (aarch64) value (defa=
ult is 0)
>      --condprob p : [ARM only] make instructions conditional with probabi=
lity p
>                     (default is 0, ie all instructions are always execute=
d)
> +    --group name[,name..]: only use instructions in defined groups
>      --pattern re[,re...] : only use instructions matching regular expres=
sion
>                     Each re must match a full word (that is, we match on
>                     the perl regex '\\b((re)|(re))\\b'). This means that
> @@ -305,6 +323,7 @@ sub main()
>      GetOptions( "help" =3D> sub { usage(); exit(0); },
>                  "numinsns=3Di" =3D> \$numinsns,
>                  "fpscr=3Do" =3D> \$fpscr,
> +                "group=3Ds" =3D> \@group,
>                  "pattern=3Ds" =3D> \@pattern_re,
>                  "not-pattern=3Ds" =3D> \@not_pattern_re,
>                  "condprob=3Df" =3D> sub {
> @@ -319,6 +338,7 @@ sub main()
>      # allow "--pattern re,re" and "--pattern re --pattern re"
>      @pattern_re =3D split(/,/,join(',',@pattern_re));
>      @not_pattern_re =3D split(/,/,join(',',@not_pattern_re));
> +    @group =3D split(/,/,join(',',@group));
>
>      if ($#ARGV !=3D 1) {
>          usage();
> --
> 2.14.2

thanks
-- PMM
