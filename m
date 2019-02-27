Received: from eggs.gnu.org ([209.51.188.92]:52003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gz4mN-0001yA-Jb
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gz4mM-00015X-Fw
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:22:07 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190227012132.16271-1-david@gibson.dropbear.id.au>
	<20190227110127.GE31688@redhat.com>
	<b9f4a52e-43e0-c209-4743-2f039e96a6b9@redhat.com>
	<20190227140843.GI31688@redhat.com>
Date: Wed, 27 Feb 2019 20:21:40 +0100
In-Reply-To: <20190227140843.GI31688@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Wed, 27 Feb 2019 14:08:43 +0000")
Message-ID: <87d0ndujej.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Allow -sandbox off with --disable-seccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, otubo@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Feb 27, 2019 at 07:59:11AM -0600, Eric Blake wrote:
>> On 2/27/19 5:01 AM, Daniel P. Berrang=C3=A9 wrote:
>> > On Wed, Feb 27, 2019 at 12:21:32PM +1100, David Gibson wrote:
>> >> At present, when seccomp support is compiled out with --disable-secco=
mp
>> >> we fail with an error if the user puts -sandbox on the command line.
>> >>
>> >> That kind of makes sense, but it's a bit strange that we reject a req=
uest
>> >> to disable sandboxing with "-sandbox off" saying we don't support
>> >> sandboxing.
>> >>
>> >> This puts in a small sandbox to (correctly) silently ignore -sandbox =
off
>> >> when we don't have sandboxing support compiled in.  This makes life e=
asier
>> >> for testcases, since they can safely specify "-sandbox off" without h=
aving
>> >> to care if the qemu they're using is compiled with sandbox support or=
 not.

I can't see such test cases.  Can you give specific examples?

>> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>=20
>> > '-sandbox off'  is just syntax sugar for '-sandbox enable=3Doff', with
>> > the default arg name handled by QemuOpts.
>>=20
>> Except that libvirt probes, via query-command-line-options, whether the
>> '-sandbox' option supports the 'enable' key.  You risk breaking
>> introspection (where libvirt knows NOT to use enable=3Don|off) if -sandb=
ox
>> enable=3Doff is advertised even when the feature is not compiled in.
>
> It is even more complex than that. Libvirt looks for "elevateprivileges"
> option to decide to enable the sandbox. It only looks for "enable" when
> libvirt is configured to disable the sandbox, at which point is sets
> "-sandbox off". So I don't think my suggestion should break it.
>
> I do hate the idea of QEMU tailoring its CLI handling to suit the
> current specific impl of one client app though.
>
> If anything I'd suggest we should completely disable any parsing
> of -sandbox when seccomp is disabled, rather than leaving getopt
> to parse -sandbox and then raise an error.

I'm confused.  Are you proposing to silently ignore -sandbox OPTARG
regardless of OPTARG when CONFIG_SECCOMP is off?  If yes, I object.  If
a user asks for a sandbox, and we can't give him one, we should at least
tell him as much.

>> > If we want to keep ability to run "-sandbox off" we should do it via
>> > the QEMU opts code we already have in the first part of the conditiona=
l,
>> > so that "-sandbox enable=3Doff" also works as normal.
>> >=20
>> > Essentially we need to push the #ifdef CONFIG_SECCOMP down into the
>> > parse_sandbox method, so that it parses the "enable" option normally
>> > but rejects any value except disabled..
>> >=20
>> > The QemuOptsList should also be conditional to only register the
>> > "enable"  arg and not the other bits.
>>=20
>> Whatever we do here had better be careful that the introspection used by
>> libvirt doesn't break, when libvirt is trying to learn when seccomp was
>> not compiled in.

Currently, we have both

    #ifdef CONFIG_FOO
                case QEMU_OPTION_FOO:
                    ...
                    break;
    #endif

and


                case QEMU_OPTION_FOO:
    #ifdef CONFIG_FOO
                    ...
                    break;
    #else
                    error_report("FOO support is disabled");
                    exit(1);
    #endif

The patch adds a third variant.  We need fewer variants, not more.

For what it's worth, conditional QMP commands do not exist when
disabled, like the first variant above.  In particular, introspection
doesn't have them.  Nicely obvious.

QAPIfying the command line (yes, yes, overdue) should make it more like
QMP.

Wanting nicer errors than "unknown option / command" is legitimate.

Wanting to accept "switch FOO off" even though FOO is disabled is also
legitimate.

Patches that provide such UI niceties while keeping introspection nicely
obvious would be acceptable to me, provided they're not too complex.
But they should be general, not a one-off.
