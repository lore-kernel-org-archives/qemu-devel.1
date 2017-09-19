Received: from eggs.gnu.org ([2001:4830:134:3::10]:39041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duGNm-0001xp-Lf
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duGNl-000307-JB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:08:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:22636 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1duGNl-0002yT-5h
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:08:01 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-7-vsementsov@virtuozzo.com>
	<b016f0b6-c7bd-eef3-caee-47f7da7d8deb@redhat.com>
	<48c3e73c-d142-7a46-a6be-b4c05349aa81@virtuozzo.com>
	<268eb4fb-b61e-403c-0c5a-80bab84ef4e2@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bb0f5896-7cb2-0a74-5ecd-2f9910ee7264@virtuozzo.com>
Date: Tue, 19 Sep 2017 14:07:52 +0300
MIME-Version: 1.0
In-Reply-To: <268eb4fb-b61e-403c-0c5a-80bab84ef4e2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/nbd-client: early fail
 nbd_read_reply_entry if s->quit is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

19.09.2017 13:03, Paolo Bonzini wrote:
> On 19/09/2017 11:43, Vladimir Sementsov-Ogievskiy wrote:
>>> I'm trying to look forward to structured reads, where we will have to
>>> deal with more than one server message in reply to a single client
>>> request.  For read, we just piece together portions of the qiov until
>>> the server has sent us all the pieces.  But for block query, I really do
>>> think we'll want to defer to specialized handlers for doing further
>>> reads (the amount of data to be read from the server is not known by the
>>> client a priori, so it is a two-part read, one to get the length, and
>>> another to read that remaining length); if we need some sort of callback
>>> function rather than cramming all the logic here in the main read loop,
>> by patch 3 I do not mean in any way that I want to have all reading
>> staff in one function, ofcourse it should be refactored
>> for block-status addition. I just want to have all reading staff in one
>> coroutine. Reading from ioc is sequential, so it's
>> native to do it sequentially in one coroutine, without switches.
> But why is that a goal?  See it as a state machine that goes between the
> "waiting for header" and "waiting for payload" states.  Reading header
> corresponds to read_reply_co waiting on the socket (and reading when
> it's ready); reading payload corresponds to the request coroutine
> waiting on the socket and reading when it's ready.
>
> Paolo


I just dislike public access to ioc for commands and extra coroutine 
switching and synchronization.



-- 
Best regards,
Vladimir
