Received: from eggs.gnu.org ([2001:4830:134:3::10]:55750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXU6m-0006u7-PN
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXU6i-0003LM-Po
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:12:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40514 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fXU6i-0003KA-Jt
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:12:48 -0400
References: <20180622022035.18490-1-f4bug@amsat.org>
	<20180622061513-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0439f4a8-f989-ead4-5338-a58845b6ecc7@redhat.com>
Date: Mon, 25 Jun 2018 18:12:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180622061513-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] Makefile: Enable synchronized parallel
 output when possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 22/06/2018 05:22, Michael S. Tsirkin wrote:
> On Thu, Jun 21, 2018 at 11:20:35PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> The '--output-sync' option is available since GNU make 4.0.
>>
>>   5.4.1 Output During Parallel Execution
>>
>>   When running several recipes in parallel the output from each
>>   recipe appears as soon as it is generated, with the result that
>>   messages from different recipes may be interspersed, sometimes
>>   even appearing on the same line. This can make reading the output
>>   very difficult.
>>
>>   To avoid this you can use the =E2=80=98--output-sync=E2=80=99 (=E2=80=
=98-O=E2=80=99) option. This
>>   option instructs make to save the output from the commands it
>>   invokes and print it all once the commands are completed.
>>   Additionally, if there are multiple recursive make invocations
>>   running in parallel, they will communicate so that only one of
>>   them is generating output at a time.
>>
>>   There are four levels of granularity when synchronizing output,
>>   specified by giving an argument to the option (e.g., =E2=80=98-Oline=
=E2=80=99
>>   or =E2=80=98--output-sync=3Drecurse=E2=80=99).
>>
>>     none
>>       This is the default: all output is sent directly as it is
>>       generated and no synchronization is performed.
>>
>>     line
>>       Output from each individual line of the recipe is grouped
>>       and printed as soon as that line is complete. If a recipe
>>       consists of multiple lines, they may be interspersed with
>>       lines from other recipes.
>>
>>     target
>>       Output from the entire recipe for each target is grouped and
>>       printed once the target is complete. This is the default if
>>       the --output-sync or -O option is given with no argument.
>>
>>     recurse
>>       Output from each recursive invocation of make is grouped and
>>       printed once the recursive invocation is complete.
>>
>>   Regardless of the mode chosen, the total build time will be the
>>   same. The only difference is in how the output appears.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> Maybe 'line' is better for workstation and 'target/recurse' for
>> unattended builds.

For long-running tasks, such as Docker builds or unit tests, -Otarget
might make it harder to find out what's going on?  Maybe "-Oline" is
better overall, but before you send v2, what if the user is specifying
-O him/herself?

(Now that I've been taught, I'm adding "export GNUMAKEFLAGS=3D-Oline" to
my bash config file. :))

Paolo


>> doc: https://www.gnu.org/software/make/manual/html_node/Parallel-Outpu=
t.html
>> ---
>>  Makefile | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index e46f2b625a..e94c687afe 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -367,6 +367,10 @@ DOCS=3D
>>  endif
>> =20
>>  SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --quiet) BUILD_DIR=
=3D$(BUILD_DIR)
>> +ifeq ($(shell test $(firstword $(subst ., ,$(MAKE_VERSION))) -ge 4; e=
cho $$?),0)
>> +SUBDIR_MAKEFLAGS+=3D--output-sync=3Dtarget
>> +endif
>> +
>>  SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_LIS=
T))
>>  SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d, $(TARG=
ET_LIST))
>=20
> I'd probably just use -O. If they change the default it will probably b=
e
> to a better one.
