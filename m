Received: from eggs.gnu.org ([2001:4830:134:3::10]:35820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fkFAc-0000CD-Ar
	for Qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fkFAa-0004Bw-VC
	for Qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:53:34 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <10f6c96f-384f-3b4a-103e-57408f20aeb8@redhat.com>
Date: Mon, 30 Jul 2018 16:53:25 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F733DE8-4046-403D-BDDD-9C3BF6FD1318@gmail.com>
References: <20180730191447.14176-1-programmingkidx@gmail.com>
	<10f6c96f-384f-3b4a-103e-57408f20aeb8@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] Add interactive mode to
 qemu-img command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>


> On Jul 30, 2018, at 3:48 PM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 07/30/2018 02:14 PM, John Arbuckle wrote:
>> Changes qemu-img so if the user runs it without any
>> arguments, it will walk the user thru making an image
>> file.
>=20
> Please remember to cc qemu-devel on ALL patches, as suggested by =
./scripts/getmaintainer.pl.

Sorry about that. I did remember a few minutes
after sending the patch and sent it.

>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>>  qemu-img.c | 31 +++++++++++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
>=20
> Missing documentation patches (at a minimum, 'man qemu-img' should be =
updated to mention this new mode of operation).  I'm also going to be a =
stickler and require an addition to tests/qemu-iotests to ensure this =
new feature gets coverage and doesn't regress (at least, if others are =
even in favor of the idea. Personally, I'm 60-40 against the bloat, as =
telling the user to read --help is sufficient in my mind).

After talking to Max Reitz about this issue I'm
not even sure I should continue with this plan.

Another idea I have is to improve the
documentation to qemu-img. Right now it looks
very hard to look at. I'm thinking a few examples
might make things easier for the user.

>=20
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 9b7506b8ae..aa3df3b431 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -4873,6 +4873,32 @@ out:
>>      return ret;
>>  }
>>  +/* Guides the user on making an image file */
>> +static int interactive_mode()
>> +{
>> +    char format[100];
>> +    char size[100];
>> +    char name[1000];
>=20
> Eww. Fixed size buffers for user-provided input are evil.  getline() =
is your friend.
>=20
>> +
>> +    printf("\nInteractive mode (Enter Control-C to cancel)\n");
>> +    printf("Please select a format (qcow, qcow2, raw, vdi, vhdx, =
vmdk, vpc): ");
>=20
> Incomplete.  Better to generate the list dynamically by iterating over =
the QAPI enum than it is to hard-code an incomplete list - particularly =
since distros can white- or black-list particular drivers.
>=20
>> +    scanf("%100s", format);
>=20
> Eww. Repeating the limit of your fixed size buffer, without checking =
that you actually read a complete line, or that the scanf actually =
succeeded in reading.  That's dangerous if a later programmer changes =
one but not both of the two lines that are supposed to be using the same =
fixed size.  Even if we accept the direction that this patch is heading =
in, it would need to be done using more robust code.
>=20
>> +    printf("Please enter a size (e.g. 100M, 10G): ");
>> +    scanf("%100s", size);
>> +    printf("Please enter a name: ");
>> +    scanf("%1000s", name);
>=20
> A limit of 1000 has no bearing on actual file name lengths; a more =
typical limit of NAME_MAX and/or PATH_MAX may come into play first (as =
low as 256 on many systems, but on some systems, that value is =
intentionally undefined because there is no inherent limit).  Again, you =
should be using getline() and malloc'ing your result rather than using =
arbitrary (and probably wrong-size) fixed-size buffers.
>=20
>> +
>> +    const char *arguments[] =3D {"create", "-f", format, name, =
size};
>=20
> Although this is valid C99, qemu tends to prefer that you declare all =
variables at the start of the scope rather than after statements.
>=20
> You did not do ANY error checking that you actually parsed arguments =
from the user; that in turn could result in passing bogus arguments on =
to img_create() that could not normally happen via command line usage.

I was going to do error handling until I realized
img_create() is very good at telling the user
what is wrong. Anything I would add would be
redundant to what img_create() does.

>=20
> Why are you hard-coding a create, rather than going FULLY interactive =
and asking the user which sub-command (create, compare, ...) that they =
want to use?

I was only thinking about what I use qemu-img for.
You do have a good point. A fully interactive
qemu-img command would be better.

>  Note that if we do want the level of interactivity to encompass the =
choice of subcommand, that you still need to make things programmatic, =
not hard-coded.  Also, John Snow had started some work on making =
qemu-img.c and associated documentation saner, including making =
subcommands more uniform; you may want to rebase your work on top of his =
cleanups, if there is even demand for this.
>=20
>> +    int arg_count =3D 5;
>> +    int return_value;
>> +    return_value =3D img_create(arg_count, (char **)arguments);
>=20
> Can we come up with a way to not have to cast away the const, if we =
are locally supplying the arguments?
>=20
>> +    if (return_value =3D=3D 0) {
>> +        printf("Done creating image file\n");
>> +    }
>> +
>> +    return return_value;
>> +}
>> +
>>  static const img_cmd_t img_cmds[] =3D {
>>  #define DEF(option, callback, arg_string)        \
>>      { option, callback },
>> @@ -4912,8 +4938,9 @@ int main(int argc, char **argv)
>>        module_call_init(MODULE_INIT_QOM);
>>      bdrv_init();
>> -    if (argc < 2) {
>> -        error_exit("Not enough arguments");
>> +
>> +    if (argc =3D=3D 1) { /* If no arguments passed to qemu-img */
>> +        return interactive_mode();
>=20
> This is placed early-enough in main() that you never use interactive =
mode if the user passed options but no subcommand (such as 'qemu-img -T =
foo'), is that intentional?

Yes.

>  Conversely, your patch does not help if a user calls 'qemu-img =
create' without options, while it can be argued that if we want =
(partial) interactivity, why not be nice to the user and provide it at =
any step of the way rather than just when no subcommand name was given.

I figure a user wants interactive help, or
not at all. Your idea is interesting.=20

>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org


Thank you for looking at my patch.=
