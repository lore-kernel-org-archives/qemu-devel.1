Received: from eggs.gnu.org ([2001:4830:134:3::10]:34551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSMWN-0004ES-8s
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:38:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSMWJ-0007DM-7N
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:38:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSMWH-0007CG-RO
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:38:18 -0500
References: <1543343726-53531-1-git-send-email-pbonzini@redhat.com>
	<a7634330-8c47-459b-5aaa-1c4519a90dd6@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d38d529-fe32-45aa-3556-86855316341d@redhat.com>
Date: Thu, 29 Nov 2018 07:38:15 -0600
MIME-Version: 1.0
In-Reply-To: <a7634330-8c47-459b-5aaa-1c4519a90dd6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-devel for-3.1?] [PATCH] glib-compat: work
 around g_test_message bug with subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 11/27/18 12:44 PM, Eric Blake wrote:
> On 11/27/18 12:35 PM, Paolo Bonzini wrote:
>> Subprocesses are created by glib without leaving the file descriptors
>> open.=C2=A0 Therefore, g_test_message (and assertion failures, but tho=
se
>> trigger when things are going bad anyway) will think that it is writin=
g
>> to the log file descriptor, but while actually stomping on the QMP
>> file descriptor or similar.=C2=A0 This causes spurious failures, which=
 are
>> as nice to debug as the reader can imagine.=C2=A0 While I have opened =
a
>> pull request on GLib, this will probably take a while to propagate
>> to distros.
>>
>> I found this while working on qgraph, but the fix is generic.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> =C2=A0 include/glib-compat.h | 6 ++++++
>> =C2=A0 1 file changed, 6 insertions(+)
>=20
> Wow. I don't envy the debug session that you went through to finally=20
> realize this problem.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I think this is safe for 3.1-rc3 if you want it there, as minimizing=20
> spurious test failures is a good thing.

Whoops - we missed -rc3. By itself, this is not worth -rc4, but is still=20
a possible candidate if more serious stuff requires a release delay.=09

>=20
>> diff --git a/include/glib-compat.h b/include/glib-compat.h
>> index fdf95a2..989b9ef 100644
>> --- a/include/glib-compat.h
>> +++ b/include/glib-compat.h
>> @@ -113,4 +113,10 @@ gint g_poll_fixed(GPollFD *fds, guint nfds, gint=20
>> timeout);
>> =C2=A0 #pragma GCC diagnostic pop
>> +/* See https://gitlab.gnome.org/GNOME/glib/merge_requests/501 */
>> +#define g_test_message(...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_test_subprocess()) =
g_test_message(__VA_ARGS__);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>=20
> I'm surprised checkpatch.pl doesn't complain about missing {} in this=20
> macro expansion, but doing it right would mean 2 more lines, so I'm fin=
e=20
> overlooking the style.

Aha - checkpatch eventually DID flag it, as well as your use of TAB=20
characters, but patchew has enough lag that it took a few hours.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
