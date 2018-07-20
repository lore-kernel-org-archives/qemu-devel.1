Received: from eggs.gnu.org ([2001:4830:134:3::10]:38007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fgaOK-0000R9-HW
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 14:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fgaOH-0004MK-FV
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 14:44:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fgaOH-0004Li-9j
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 14:44:33 -0400
Date: Fri, 20 Jul 2018 19:44:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180720184429.GF2631@work-vm>
References: <1532012617-16777-1-git-send-email-walling@linux.ibm.com>
	<20180719191818.GD2462@work-vm>
	<97bef638-4441-3367-6c64-9339cba3c33f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97bef638-4441-3367-6c64-9339cba3c33f@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: print message when using 'help'
 with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-devel@nongnu.org

* Collin Walling (walling@linux.ibm.com) wrote:
> On 07/19/2018 03:18 PM, Dr. David Alan Gilbert wrote:
> > * Collin Walling (walling@linux.ibm.com) wrote:
> >> When typing 'help' followed by an unknown command, QEMU will
> >> not print anything to the command line to let the user know
> >> they typed a bad command. Let's fix this by printing a message
> >> to the monitor when this happens. For example:
> >>
> >>     (qemu) help xyz
> >>     unknown command: 'xyz'
> >>
> >> Reported-by: Stefan Zimmermann <stzi@linux.ibm.com>
> >> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> >> ---
> >>  monitor.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/monitor.c b/monitor.c
> >> index 7af1f18..7942f9f 100644
> >> --- a/monitor.c
> >> +++ b/monitor.c
> >> @@ -1034,9 +1034,12 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
> >>              } else {
> >>                  help_cmd_dump_one(mon, cmd, args, arg_index);
> >>              }
> >> -            break;
> >> +            return;
> >>          }
> >>      }
> >> +
> >> +    /* Entry not found */
> >> +    monitor_printf(mon, "unknown command: '%s'\n", args[arg_index]);
> > 
> > Thanks, that does suffer from a similar bug to the one you fixed a
> > few months back in  317c52cc6aa0d ('monitor: report entirety of hmp
> > command on error'):
> > 
> > (qemu) help foo
> > unknown command: 'foo'
> > (qemu) help info foo
> > unknown command: 'foo'
> 
> Yeah... my thinking was that "info" is a correct command, so let's instead only
> report to the user just the piece that was incorrect.
> 
> If it makes better sense to include the whole "info foo" piece, it's certainly
> doable... whichever makes the most sense. Thoughts?

Yes, I'd prefer the full version; unless it makes it particularly
complicated.


> > 
> > Dave
> > (And yes, please cc me, otherwise I can miss them)
> > 
> 
> Will do :)

Thanks,

Dave

> >>  }
> >>  
> >>  static void help_cmd(Monitor *mon, const char *name)
> >> -- 
> >> 2.7.4
> >>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
> 
> -- 
> Respectfully,
> - Collin Walling
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
