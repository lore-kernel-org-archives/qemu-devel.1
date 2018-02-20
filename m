Received: from eggs.gnu.org ([2001:4830:134:3::10]:54624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo4qo-0004rG-3A
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo4qk-0006Ra-UT
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:08:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo4qk-0006RO-Q6
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:08:38 -0500
Date: Tue, 20 Feb 2018 11:08:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180220100837.lijheejmk376j7tu@sirius.home.kraxel.org>
References: <20180216203856.8645-1-programmingkidx@gmail.com>
	<20180219085444.ndyga5fgwkc6kfqm@sirius.home.kraxel.org>
	<C9EC16AC-7B51-4413-9B67-7CD165FA5DF6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9EC16AC-7B51-4413-9B67-7CD165FA5DF6@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7] ui/cocoa.m: Add ability for user to
 specify mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

> >>         case NSEventTypeKeyUp:
> >>             keycode = cocoa_keycode_to_qemu([event keyCode]);
> >> 
> >> +            if (are_sets_equal(ungrab_set, key_set)) {
> >> +                [self ungrabMouse];
> >> +                clear_set(key_set);
> >> +                return;
> >> +            }
> >> +            send_key_if_delayed(key_set, keycode);
> >> +            remove_number(key_set, keycode);
> > 
> > This doesn't maintain the event ordering.
> 
> I need more clearifiction.
> 
> If the ungrab keys are 1-2-3, and the user does this:
> down: 2
> down: 3
> down: 4
> 
> The only input that is sent to the guest is the 4. The 2 and 3 are
> forgotten about. You want the 2 and the 3 sent to the guest in the
> order they were pushed?

Yes.

> Is there another condition that needs work.

Well, basically if the key combination pressed isn't a hotkey all key
events should be sent as-is to the guest.  No events dropped, no events
reordered.

You can't use a set for this, because you don't know the event order
then.  With ungrab key 1-2-3 and this event sequence ...

  down: 1
  down: 2
  up: 2
  up: 1

... your send_key_if_delayed() logic sends this to the guest:

  down: 2
  up: 2
  down: 1
  up: 1

cheers,
  Gerd
