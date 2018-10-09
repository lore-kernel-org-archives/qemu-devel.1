Received: from eggs.gnu.org ([2001:4830:134:3::10]:57000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g9tTb-00073K-8n
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g9tT5-0005Ol-Ct
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:11 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1g9tT2-0005EY-EH
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:58:39 -0400
References: <20180928142533.8451-1-peter.maydell@linaro.org>
	<52177933-047f-d99b-e7d7-2a85e4c8d59c@vivier.eu>
	<eee0054a-4d73-53a2-ca52-dbce4f1996e5@vivier.eu>
	<CAFEAcA_3o3FSScwUcrDX2aFoj-RvNjo=F_Em2HaP=pK5o4=Bng@mail.gmail.com>
	<2998097f-bb40-409c-16aa-f8bef811444c@linaro.org>
	<1947e824-2aec-1d93-3b96-f472a7a88611@vivier.eu>
	<CAFEAcA-F+=h=Hm71RpXF5wTQaq2bG7jBxMSbm0d2mCyHtXBGwg@mail.gmail.com>
	<CAFEAcA_qoEhd6XSyiQbF73zVFAdRwO=4dQx-T17i3DcZqXCCVw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5595b766-b403-3c2d-5c29-c70f770b9c77@vivier.eu>
Date: Tue, 9 Oct 2018 16:57:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_qoEhd6XSyiQbF73zVFAdRwO=4dQx-T17i3DcZqXCCVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Suppress
 address-of-packed-member warnings in __get/put_user_e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, "patches@linaro.org" <patches@linaro.org>

Le 09/10/2018 à 16:52, Peter Maydell a écrit :
> On 9 October 2018 at 12:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 5 October 2018 at 17:09, Laurent Vivier <laurent@vivier.eu> wrote:
>>> Could it be a bug in _Pragma()?
>>
>> I got an f28 VM and can repro this. It looks like the problem
>> only happens when the get_user/put_user stuff is used via some
>> other macro, for some reason -- so the GET_ARG and SET_ARG
>> macros in arm-semi.c and the NEW_AUX_ENT macro in elfload.c
>> cause problems, but less indirect use does not. I'll try to
>> trim this down to a smaller test case somehow...
> 
> I think it is a bug in _Pragma(). I boiled it down to a
> small test case, and tested using the compilers on godbolt.org.
> The test fails with gcc 5, 6, 7 and 8 but works on 4 and on
> gcc trunk.
> 
> Trying to use _Pragma() inside a macro to disable warnings
> seems to be pretty broken. The GCC bugzilla has:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85153
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69558
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82335
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66099
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=55578
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69543
> 
> which are various bug reports in this area, with test cases
> which variously are fixed in gcc 8, or fixed not in 8 but
> in trunk, or still broken in trunk. So there isn't a single
> bug here but a cluster of similar ones.
> 
> I think the underlying difficulty is that the compiler decides
> whether to suppress the warning by looking at the source location
> for the warning, and at the source locations of the various
> pragmas, and especially when macro expansion is involved the
> "source location" can be harder to correctly identify.
> 
> I'm not sure if there is some "safe" subset of _Pragma()-in-macro
> use here that will work regardless of compiler version, or if
> we should just give up on it as non-feasible and try to silence
> the warnings some other way.

To keep it simple, and as I have suggested before, perhaps you can use
only the _Pragma() we need to workaround clang bug with clang (#ifde
__clang__)?

Thanks,
Laurent
