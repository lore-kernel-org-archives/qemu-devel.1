Received: from eggs.gnu.org ([2001:4830:134:3::10]:56579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqEAf-0005LP-W6
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqEAa-0002VX-3B
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqEAZ-0002UZ-6u
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:15 -0400
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
	<d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
	<8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
	<80532e46-ffbf-9c87-5296-741bbb6f83ac@redhat.com>
	<d5ad3096-86b1-29e4-47bd-1ca71b8e7879@bluestop.org>
	<1feb3cc1-86ee-f708-6dc7-b9e20a7588ac@redhat.com>
	<327f3e04-dd5b-06bd-f672-5f180521db32@gmx.com>
	<3ed5e351-80be-9707-773d-0b65a7e0b4dc@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bb77b1ca-a5da-4023-26d9-b330f476d249@redhat.com>
Date: Thu, 16 Aug 2018 11:02:11 +0200
MIME-Version: 1.0
In-Reply-To: <3ed5e351-80be-9707-773d-0b65a7e0b4dc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RDMA wrongly detected as being supported on FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kamil Rytarowski <n54@gmx.com>, Rebecca Cran <rebecca@bluestop.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>, Brad Smith <brad@comstyle.com>

On 08/16/2018 10:55 AM, Marcel Apfelbaum wrote:
>=20
>=20
> On 08/15/2018 04:37 PM, Kamil Rytarowski wrote:
>> On 06.08.2018 10:51, Thomas Huth wrote:
>>> On 07/28/2018 05:50 AM, Rebecca Cran wrote:
>>>> On 7/25/18 5:14 AM, Thomas Huth wrote:
>>>>
>>>>> Note that the error has been reported to happen on FreeBSD - so I
>>>>> doubt
>>>>> that this <linux/types.h> header should be here.
>>>>>
>>>>> Anyway, our include/standard-headers/linux/types.h is also empty
>>>>> ... so
>>>>> could you try whether it compiles if you simply remove this #includ=
e
>>>>> line, Rebecca?
>>>>
>>>> Sorry for the delay, I'm just getting back to this. Removing the
>>>> include
>>>> causes it to fail later on, with:
>>>>
>>>> /home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning:
>>>> implicit declaration of function 'mremap' is invalid in C99
>>>> [-Wimplicit-function-declaration]
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 host_virt =3D mremap(curr_page, 0, length, =
MREMAP_MAYMOVE);
>>> OK, thanks for checking. According to
>>>
>>> =C2=A0 https://www.freebsd.org/cgi/man.cgi?query=3Dmremap&manpath=3DN=
etBSD+5.0
>>>
>>> that syscall should also be available on FreeBSD. So could you please=
 do
>>> one more test and see whether it works when you add the following lin=
e
>>> somewhere at the beginning of the file:
>>>
>>> =C2=A0=C2=A0 #include <sys/mman.h>
>>>
>>> =C2=A0 Thanks,
>>> =C2=A0=C2=A0 Thomas
>>>
>> I'm a little bit disoriented. The linked page is from NetBSD in a very
>> old version 5.x. We have 8.0 out now.
>>
>> The thread is about FreeBSD. If there are any questions regarding
>> NetBSD, please let me know.
>=20
> Indeed, the linked page didn't help, we are referring to FreeBSD
> which doesn't support mremap, at least by default.

Sorry, my bad, I was tricked by the freebsd.org domain. So I guess the
right thing to do is a check for mremap in the configure script and only
include that rdma code if mremap is available?

 Thomas
