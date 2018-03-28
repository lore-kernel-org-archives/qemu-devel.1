Received: from eggs.gnu.org ([2001:4830:134:3::10]:38250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f1BvN-0002AB-Uh
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f1BvK-000137-PH
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:19:37 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f1BvK-00012u-JE
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:19:34 -0400
Received: by mail-io0-f196.google.com with SMTP id l3so3760620iog.0
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 07:19:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6fca462f-7aca-f743-6f43-8475b6501014@redhat.com>
References: <20180328130723.20831-1-marcandre.lureau@redhat.com>
	<20180328130723.20831-3-marcandre.lureau@redhat.com>
	<a74de730-cf65-056c-dfa1-2fcc9361b9a1@redhat.com>
	<CAMxuvayFZiYwf99mbMVFVwFZR2Bnqfv4rYS1O2SpDT1mhFtAEg@mail.gmail.com>
	<ac132600-ac94-c9b7-b280-f2ff2ebebf74@redhat.com>
	<6fca462f-7aca-f743-6f43-8475b6501014@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Mar 2018 16:19:33 +0200
Message-ID: <CAMxuvazJp57yr6f5B=v3GYYyRkrWY9x9zKAUK_TtZHx2hcY2Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qobject: introduce QObjectCommon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>

Hi

On Wed, Mar 28, 2018 at 4:11 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 28/03/2018 15:55, Eric Blake wrote:
>> On 03/28/2018 08:48 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>>>>> +#define QOBJECT(x) \
>>>>> +   container_of(&(x)->base, QObject, base)
>>>>
>>>>
>>>> If I understand correctly, this still causes clang complaints when
>>>> called as
>>>> QOBJECT(NULL).  As long as we are touching this, should we improve thi=
s
>>>> macro to be friendly to NULL conversion?
>>>
>>> I don't see much need for allowing NULL (literally) to be passed to
>>> QOBJECT(). If it's a null pointer, as long as it has the right type,
>>> it should be fine, shouldn't it?
>>
>> Not with clang ubsan (okay, the failure is at runtime, not compile time)=
:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05143.html
>> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05148.html
>>
>> Even when the offset is 0, the mere fact that you are computing an
>> offset relative to a NULL pointer is undefined behavior.
>
> Are there cases where we are passing NULL to qobject_{inc,dec}ref?  They
> currently have an "if" in they're body, but my opinion is they ought to
> crash and burn...

I find it convenient that unref() accepts NULL, just like free().

However, I agree than ref() should crash if given a NULL pointer.

While at it, I'd also prefer ref() to return a pointer to the same object..=
.
