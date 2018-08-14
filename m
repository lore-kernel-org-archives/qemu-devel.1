Received: from eggs.gnu.org ([2001:4830:134:3::10]:43369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fpa9Y-0001tp-2o
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fpa9T-000320-Mx
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:18:32 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:58621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fpa9T-00031O-DM
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:18:27 -0400
Date: Tue, 14 Aug 2018 16:18:26 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180814141826.GA26558@ruderich.org>
References: <cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<20180810103650.GA2391@work-vm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-15630-1534256306-0001-2"
Content-Disposition: inline
In-Reply-To: <20180810103650.GA2391@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-15630-1534256306-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 11:36:51AM +0100, Dr. David Alan Gilbert wrote:
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -822,6 +822,20 @@ STEXI
>>  @item pmemsave @var{addr} @var{size} @var{file}
>>  @findex pmemsave
>>  save to disk physical memory dump starting at @var{addr} of size @var{s=
ize}.
>> +ETEXI
>> +
>> +    {
>> +        .name       =3D "pmemload",
>> +        .args_type  =3D "val:l,size:i,offset:i,filename:s",
>> +        .params     =3D "addr size offset file",
>> +        .help       =3D "load from disk physical memory dump starting a=
t 'addr' of size 'size' at file offset 'offset'",
>> +        .cmd        =3D hmp_pmemload,
>> +    },
>> +
>
> I'm guessing that size and offset should be 'l' to allow large
> sizes and offsets, and there's an 'F' type for filenames

I've copied that from "pmemsave" and "memsave" which use 'i' for
size. I'll add patches which will adapt them to use both 'l' and
'F' and adapt my pmemload patch as well.

qapi/misc.json seems to always use 'int' for integer types. Is
this value large enough on 64-bit architectures?

> (see monitor.c which has a big comment table near the start).

Thanks.

Just curious, what is the difference between 's' and 'F'. Is that
only for documentation purposes (and maybe tab completion) or is
the usage different? I noticed existing code uses qdict_get_str()
for both 's' and 'F'.

> Also, had you considered rearranging and making them optional,
> for example if you do:
>
> val:l,filename:F,offset:i?,size:i?
>
> I think that would mean you can do the fairly obvious:
>   pmemload addr "myfile"
>
> with the assumption that loads the whole file.

I tried to keep it as similar to the existing functions
"memsave"/"pmemsave", only adding "offset". Eric Blake already
raised this issue in the thread, here's my response for
reference:

On Mon, Apr 23, 2018 at 02:46:57PM -0500, Eric Blake wrote:
> Back-compat in the QMP interface matters.  The HMP interface, however,
> exists to serve humans not machines, and we can break it at will to
> something that makes more sense to humans.  So don't let HMP concerns
> hold you back from a sane interface.

I see. However I don't like breaking existing interfaces unless I
have to. In this case I think not having the optional parameters
is fine and the consistency between the existing memsave/pmemsave
functions is more important.

> Optional parameters are listed as '*name':'type' in the .json file,
> which tells the generator to create a 'has_name' bool parameter
> alongside the 'name' parameter in the C code for the QMP interface.  The
> HMP interface should then call into the QMP interface.
>
> Recent HMP patches that I've authored may offer some inspiration: commit
> 08fb10a added a new command, and commit dba4932 added an optional
> parameter to an existing command.

Thank you for the explanation, this looks straight-forward.

Do you have strong opinions regarding the optional parameters or
would you accept the patch as is (minus possible implementation
issues)? I like the symmetry to the existing functions (I noticed
that size can only be optional for pmemload because saving the
complete memory doesn't sound useful) and having to specify
size/offset doesn't hurt the caller too much.


Thanks for your review!

Regards
Simon

PS: Diff between v3 and my current local version follows:

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5a43dae133..c39d745a22 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -818,7 +818,7 @@ ETEXI
=20
     {
         .name       =3D "memsave",
-        .args_type  =3D "val:l,size:i,filename:s",
+        .args_type  =3D "val:l,size:l,filename:F",
         .params     =3D "addr size file",
         .help       =3D "save to disk virtual memory dump starting at 'add=
r' of size 'size'",
         .cmd        =3D hmp_memsave,
@@ -832,7 +832,7 @@ ETEXI
=20
     {
         .name       =3D "pmemsave",
-        .args_type  =3D "val:l,size:i,filename:s",
+        .args_type  =3D "val:l,size:l,filename:F",
         .params     =3D "addr size file",
         .help       =3D "save to disk physical memory dump starting at 'ad=
dr' of size 'size'",
         .cmd        =3D hmp_pmemsave,
@@ -846,7 +846,7 @@ ETEXI
=20
     {
         .name       =3D "pmemload",
-        .args_type  =3D "val:l,size:i,offset:i,filename:s",
+        .args_type  =3D "val:l,size:l,offset:l,filename:F",
         .params     =3D "addr size offset file",
         .help       =3D "load from disk physical memory dump starting at '=
addr' of size 'size' at file offset 'offset'",
         .cmd        =3D hmp_pmemload,
diff --git a/qapi/misc.json b/qapi/misc.json
index 6c34b2ff8b..becc257a76 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1196,7 +1196,7 @@
 #
 # Returns: Nothing on success
 #
-# Since: 2.13
+# Since: 3.1
 ##
 { 'command': 'pmemload',
   'data': {'val': 'int', 'size': 'int', 'offset': 'int', 'filename': 'str'=
} }

--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-15630-1534256306-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlty5LEACgkQkv79t+RM
MvmbQw//ZKaBPJr7+9XLO/VAY72B19jQLAlqGORl/1YWX+NP7z6Lr1/6cmH5TIYZ
w0HEAObBdYfGC6ElQ7I3cODg6saRoDGv1LFP2trYS5zwWooQ9W609HaNfIIjO6D8
nBYuMNZfz6WOSJxBWfYZwkcPAxxYsQLamPQDbGZGCimAeAyJTIMejhx5b4fGngn/
k7nu+ymsRSlXB4PrAIw3Is1lc3ogW4lpIKcSYtkhp+CeC3zcR/W9orIaq12jqhB5
Ta6IV3UafbSPByxIrbY/R+XHdZzDnmZhlh3DmNKcYiG4mA7dNKl/MBaJpuTkc4Qq
HPwIZF1KV4ZgRDXGvjnttIzKVfUISbKRM8LBwzpT+Ws06t3JH9AX1I01WI48Sanf
m50Oulhh7qbc9h/t9FOp6HzY79rAAM0swxtboJy+HJdwuhCuedJg/cyNCC5S3LbB
4F1GcXeKEW7JHA0IFG+7eRj7q5ZPTKQeG+Bw09jO8A0vtdzj8wDxsqsaDmlMRQaN
0uDhDbnORMyuhwXvbdNtMYf5kiHl3IHg99gAAJR2z80xiybNtx2bX6T/TgiFKqA5
ug8oBEjxSCM72MMx5/5tGGYhBGccaEkWa1OUGCt1f3JTpsowD2vppOQJkf8kTee2
aiGEy4OsTp1xIwk53DZ5kUl2uJO0XJKM/rSA1yBg5EKUBoX7YDY=
=iKKV
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-15630-1534256306-0001-2--
