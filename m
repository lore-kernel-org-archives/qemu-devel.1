Received: from eggs.gnu.org ([2001:4830:134:3::10]:43300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fad78-00068h-1L
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fad73-0004TD-Io
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:26:14 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fad73-0004Sw-3J
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:26:09 -0400
Received: by mail-wr0-x244.google.com with SMTP id b8-v6so4403732wro.6
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 01:26:08 -0700 (PDT)
References: <20180703160022.10705-1-alex.bennee@linaro.org>
	<bd71ddfb-1f94-605a-ac94-bd372d34bddd@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <bd71ddfb-1f94-605a-ac94-bd372d34bddd@vivier.eu>
Date: Wed, 04 Jul 2018 09:26:06 +0100
Message-ID: <8736wz9zkx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/qemu-binfmt-conf.sh: allow
 clearing of entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 03/07/2018 =C3=A0 18:00, Alex Benn=C3=A9e a =C3=A9crit:
>> Currently running the script twice will fail with "sh: echo: I/O
>> error" as the registration is already complete. Add a new option
>> --clear to reset the entries to save the user doing it by hand.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  scripts/qemu-binfmt-conf.sh | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
>> index d7eefda0b8..13ef4713e6 100755
>> --- a/scripts/qemu-binfmt-conf.sh
>> +++ b/scripts/qemu-binfmt-conf.sh
>> @@ -160,7 +160,7 @@ qemu_get_family() {
>>  usage() {
>>      cat <<EOF
>>  Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>> -                           [--help][--credential yes|no][--exportdir PA=
TH]
>> +                           [--help][--clear][--credential yes|no][--exp=
ortdir PATH]
>>
>>         Configure binfmt_misc to use qemu interpreter
>>
>> @@ -176,6 +176,7 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debi=
an][--systemd CPU]
>>                       (default: $SYSTEMDDIR or $DEBIANDIR)
>>         --credential: if yes, credential and security tokens are
>>                       calculated according to the binary to interpret
>> +       --clear:      clear existing qemu binfmt registrations
>>
>>      To import templates with update-binfmts, use :
>>
>> @@ -249,6 +250,13 @@ qemu_register_interpreter() {
>>      qemu_generate_register > /proc/sys/fs/binfmt_misc/register
>>  }
>>
>> +qemu_clear_interpreter() {
>> +    if [ -e /proc/sys/fs/binfmt_misc/qemu-$cpu ]; then
>
> You should use qemu_check_access()
>
>> +        echo "Removing qemu-$cpu as binfmt interpreter for $cpu"
>> +        echo -1 > /proc/sys/fs/binfmt_misc/qemu-$cpu
>> +    fi
>> +}
>> +
>>  qemu_generate_systemd() {
>>      echo "Setting $qemu as binfmt interpreter for $cpu for systemd-binf=
mt.service"
>>      qemu_generate_register > "$EXPORTDIR/qemu-$cpu.conf"
>> @@ -302,7 +310,7 @@ DEBIANDIR=3D"/usr/share/binfmts"
>>  QEMU_PATH=3D/usr/local/bin
>>  FLAGS=3D""
>>
>> -options=3D$(getopt -o ds:Q:e:hc: -l debian,systemd:,qemu-path:,exportdi=
r:,help,credential: -- "$@")
>> +options=3D$(getopt -o ds:Q:e:hc: -l debian,systemd:,qemu-path:,exportdi=
r:,help,clear,credential: -- "$@")
>>  eval set -- "$options"
>>
>>  while true ; do
>> @@ -354,6 +362,10 @@ while true ; do
>>              FLAGS=3D""
>>          fi
>>          ;;
>> +    --clear)
>> +        shift
>> +        BINFMT_SET=3Dqemu_clear_interpreter
>> +        ;;
>>      *)
>>          break
>>          ;;
>>
>
> if you use --debian or --systemd, you don't have the problem because
> update-binfmts and systemd-binfmt.service update /proc from the
> generated files for you.

Usually I just "apt install qemu-user" and be done with it but I was
writing up a blog post and trying to keep it as distro agnostic as
possible.

>
> But you're right there is no command to undo what we have done.
> You manage only the /proc case, I think it would be also useful to
> remove the files from $EXPORTDIR.
>
> So could you also manage something like "--debian --clear" and
> "--systemd CPU --clear"?

Sure, I'll look into it.

>
> Thanks,
> Laurent


--
Alex Benn=C3=A9e
