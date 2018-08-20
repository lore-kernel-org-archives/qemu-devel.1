Received: from eggs.gnu.org ([2001:4830:134:3::10]:49050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1frnmx-00079v-An
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1frnmt-0003Az-AY
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:16:23 -0400
References: <20180818025653.21192-1-f4bug@amsat.org>
	<66dfe354-9c2c-8642-a905-03155555fe99@redhat.com>
	<a812530c-ad1b-f5ff-6e15-82227cb76c79@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2fd04596-a8a0-889f-239d-92853c12c6aa@redhat.com>
Date: Mon, 20 Aug 2018 19:16:14 +0200
MIME-Version: 1.0
In-Reply-To: <a812530c-ad1b-f5ff-6e15-82227cb76c79@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: Replace strncpy() by g_strlcpy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 2018-08-20 15:28, David Hildenbrand wrote:
> On 20.08.2018 15:23, Paolo Bonzini wrote:
>> On 18/08/2018 04:56, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Fedora 29 comes with GCC 8.1 which added the 'stringop-truncation' ch=
ecks.
>>>
>>> Replace the strncpy() calls by g_strlcpy() to avoid the following war=
ning:
>>>
>>>   migration/global_state.c: In function 'global_state_store_running':
>>>   migration/global_state.c:45:5: error: 'strncpy' specified bound 100=
 equals destination size [-Werror=3Dstringop-truncation]
>>>        strncpy((char *)global_state.runstate,
>>>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>               state, sizeof(global_state.runstate));
>>>               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> See http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03723.=
html
>>>
>>>  migration/global_state.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/migration/global_state.c b/migration/global_state.c
>>> index 8e8ab5c51e..d5df502cd5 100644
>>> --- a/migration/global_state.c
>>> +++ b/migration/global_state.c
>>> @@ -42,7 +42,7 @@ int global_state_store(void)
>>>  void global_state_store_running(void)
>>>  {
>>>      const char *state =3D RunState_str(RUN_STATE_RUNNING);
>>> -    strncpy((char *)global_state.runstate,
>>> +    g_strlcpy((char *)global_state.runstate,
>>>             state, sizeof(global_state.runstate));
>>>  }
>>> =20
>>>
>>
>> This is wrong because strlcpy doesn't zero the rest of
>=20
> Two RB-s and it is still wrong implies that string operations are still
> the root of all evil. :)
>=20
>> global_state.runstate, so you could end up with something like
>> "running\0ate\0\0..." in global_state.runstate However, the same mista=
ke
>> is already present in vl.c's runstate_store.
>>
>> Juan, David, what to do?  strncpy is easy to misuse, but we do have
>> cases where it's correct and it should tingle the reviewers' spidey
>> senses...  I wouldn't mind disabling the warning, and using strncpy in
>> runstate_store, because in practice it's already reported by Coverity
>> and it can be shut up there.
>=20
> Maybe really set it to zero (memset) before using the g_strlcpy? I am
> not a fan of disabling warnings, but if you think this is
> easier/cleaner, let's go for that.

FWIW, that new warning from GCC is IMHO just annoying. I had the same
problem in the SLOF sources, too:

https://github.com/aik/SLOF/commit/d8a9354c2a35136

The code with strncpy was perfectly valid before, but to get rid of the
warning, I replaced it with a more cumbersome memcpy instead (and mad
sure that the memory is already cleared earlier in that function). Now
seeing that the problem with strncpy pops up here, too, I think it would
maybe be better to shut up the warning of GCC, since it's clearly GCC
who's wrong here.

 Thomas
