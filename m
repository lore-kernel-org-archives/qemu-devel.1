Received: from eggs.gnu.org ([2001:4830:134:3::10]:56232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRiYz-0000Ve-RD
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRiYx-0003fT-7V
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:58:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRiYx-0003fG-0E
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:58:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 611D63C2CFB
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 18:58:22 +0000 (UTC)
References: <1543343726-53531-1-git-send-email-pbonzini@redhat.com>
	<a7634330-8c47-459b-5aaa-1c4519a90dd6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd72c676-761a-2561-7148-c9a7974ff059@redhat.com>
Date: Tue, 27 Nov 2018 19:58:18 +0100
MIME-Version: 1.0
In-Reply-To: <a7634330-8c47-459b-5aaa-1c4519a90dd6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] glib-compat: work around g_test_message
 bug with subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 27/11/18 19:44, Eric Blake wrote:
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
> Wow. I don't envy the debug session that you went through to finally
> realize this problem.

It only took me 4 hours actually, but not really the fun kind of
debugging. :(  Lots of cursing when I found the culprit...

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I think this is safe for 3.1-rc3 if you want it there, as minimizing
> spurious test failures is a good thing.

I suspect it is the cause of QTEST_VHOST_USER_FIXME but I am not sure it
is.  In any case, I was not planning to merge it in 3.1-rc3 since we do
not have any case where it breaks CI or maintainers' tests.

Paolo
